require 'optparse'
require 'tempfile'
require 'zip'
require 'zip/filesystem'
require 'plist'
require 'json'


# -------------------------
# --- Options

options = {
	ipa_path: nil,
	is_verbose: false,
	is_pretty: false,
	is_collect_provision_info: false,
	is_collect_info_plist: false
}

opt_parser = OptionParser.new do |opt|
	opt.banner = "Usage: ipa_analyzer.rb [OPTIONS]"
	opt.separator  ""
	opt.separator  "Options, the ones marked with * are required"

	opt.on("-i","--ipa IPA_PATH", "*IPA file path") do |value|
		options[:ipa_path] = value
	end

	opt.on("--prov","Collect Provisioning Profile (mobileprovision) information from the IPA") do
		options[:is_collect_provision_info] = true
	end

	opt.on("--info-plist","Collect Info.plist information from the IPA") do
		options[:is_collect_info_plist] = true
	end

	opt.on("-v","--verbose","Verbose output") do
		options[:is_verbose] = true
	end

	opt.on("-p","--pretty","Pretty print output") do
		options[:is_pretty] = true
	end

	opt.on("-h","--help","Shows this help message") do
		puts opt_parser
		exit 0
	end
end

opt_parser.parse!
$options = options


# -------------------------
# --- Utils

def vputs(msg="")
	if $options[:is_verbose]
		puts msg
	end
end


#
# Find the .app folder which contains both the "embedded.mobileprovision"
#  and "Info.plist" files.
def find_app_folder_in_ipa(zipfile, ipa_path)
	# Check the most common location
	app_folder_in_ipa = "Payload/#{File.basename(ipa_path, File.extname(ipa_path))}.app"
	#
	mobileprovision_entry = zipfile.find_entry("#{app_folder_in_ipa}/embedded.mobileprovision")
	info_plist_entry = zipfile.find_entry("#{app_folder_in_ipa}/Info.plist")
	#
	if !mobileprovision_entry.nil? and !info_plist_entry.nil?
		vputs "* .app folder detected at common location: #{app_folder_in_ipa}"
		return app_folder_in_ipa
	end

	# It's somewhere else - let's find it!
	zipfile.dir.entries("Payload").each do |dir_entry|
		if dir_entry =~ /.app$/
			app_folder_in_ipa = "Payload/#{dir_entry}"
			mobileprovision_entry = zipfile.find_entry("#{app_folder_in_ipa}/embedded.mobileprovision")
			info_plist_entry = zipfile.find_entry("#{app_folder_in_ipa}/Info.plist")

			if !mobileprovision_entry.nil? and !info_plist_entry.nil?
				vputs "* .app folder detected at: #{app_folder_in_ipa}"
				break
			end
		end
	end

	if !mobileprovision_entry.nil? and !info_plist_entry.nil?
		return app_folder_in_ipa
	end
	return nil
end

def collect_provision_info(zipfile, app_folder_path, ipa_path)
	result = {
		path_in_ipa: nil,
		content: {}
	}
	mobileprovision_path = "#{app_folder_path}/embedded.mobileprovision"
	mobileprovision_entry = zipfile.find_entry(mobileprovision_path)

	raise "Embedded mobile provisioning file not found in (#{ipa_path}) at path (#{mobileprovision_path})" unless mobileprovision_entry
	vputs "* mobile provisioning: #{mobileprovision_entry}"
	result[:path_in_ipa] = "#{mobileprovision_entry}"

	tempfile = Tempfile.new(::File.basename(mobileprovision_entry.name))
	begin
		zipfile.extract(mobileprovision_entry, tempfile.path){ override = true }
		plist = Plist::parse_xml(`security cms -D -i #{tempfile.path}`)

		plist.each do |key, value|
			next if key == "DeveloperCertificates"

			vputs
			vputs "----------------"
			vputs "key: #{key}"
			parse_value = nil
			case value
			when Hash
				parse_value = value
			when Array
				parse_value = value
			else
				parse_value = value.to_s
			end
			vputs "parse_value: #{parse_value}"

			result[:content][key] = parse_value
		end

	rescue => e
		puts e.message
		exit_code = 1
	ensure
		tempfile.close and tempfile.unlink
	end
	return result
end

def collect_info_plist_info(zipfile, app_folder_path, ipa_path)
	result = {
		path_in_ipa: nil,
		content: {}
	}
	info_plist_entry = zipfile.find_entry("#{app_folder_path}/Info.plist")

	raise "File 'Info.plist' not found in #{ipa_path}" unless info_plist_entry
	vputs "* info_plist_entry: #{info_plist_entry}"
	result[:path_in_ipa] = "#{info_plist_entry}"

	tempfile = Tempfile.new(::File.basename(info_plist_entry.name))
	begin
		zipfile.extract(info_plist_entry, tempfile.path){ override = true }
		# convert from binary Plist to XML Plist
		unless system("plutil -convert xml1 '#{tempfile.path}'")
			raise "Failed to convert binary Plist to XML"
		end
		plist = Plist::parse_xml(tempfile.path)

		plist.each do |key, value|
			vputs
			vputs "----------------"
			vputs "key: #{key}"
			parse_value = nil
			case value
			when Hash
				parse_value = value
			when Array
				parse_value = value
			else
				parse_value = value.to_s
			end
			vputs "parse_value: #{parse_value}"

			result[:content][key] = parse_value
		end

	rescue => e
		puts e.message
		exit_code = 1
	ensure
		tempfile.close and tempfile.unlink
	end
	return result
end

# -------------------------
# --- Main

vputs "options: #{options}"

raise "No IPA specified" unless options[:ipa_path]
raise "IPA specified but file does not exist at the provided path" unless File.exist? options[:ipa_path]

parsed_infos = {
	mobile_provision: nil
}

exit_code = 0

Zip::File.open(options[:ipa_path]) do |zipfile|
	app_folder_path = find_app_folder_in_ipa(zipfile, options[:ipa_path])
	raise "Could not find a valid '.app' folder in the provided IPA" if app_folder_path.nil?
	vputs "* app_folder_path: #{app_folder_path}"

	if options[:is_collect_provision_info]
		parsed_infos[:mobile_provision] = collect_provision_info(zipfile, app_folder_path, options[:ipa_path])
	end
	if options[:is_collect_info_plist]
		parsed_infos[:info_plist] = collect_info_plist_info(zipfile, app_folder_path, options[:ipa_path])
	end
end

if options[:is_pretty]
	puts JSON.pretty_generate(parsed_infos)
else
	puts JSON.generate(parsed_infos)
end

exit exit_code
