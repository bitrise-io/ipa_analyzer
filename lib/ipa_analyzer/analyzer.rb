require 'tempfile'
require 'zip'
require 'zip/filesystem'
require 'plist'

module IpaAnalyzer
	class Analyzer
		def initialize(ipa_path)
			@ipa_path = ipa_path
			@ipa_zipfile = nil
			@app_folder_path = nil
		end

		def open!
			@ipa_zipfile = Zip::File.open(@ipa_path)
			@app_folder_path = find_app_folder_in_ipa()
			raise "No app folder found in the IPA" if @app_folder_path.nil?
		end

		def open?
			return !@ipa_zipfile.nil?
		end

		def close
			if self.open?
				@ipa_zipfile.close()
			end
		end

		def collect_provision_info
			raise "IPA is not open" unless self.open?

			result = {
				path_in_ipa: nil,
				content: {}
			}
			mobileprovision_path = "#{@app_folder_path}/embedded.mobileprovision"
			mobileprovision_entry = @ipa_zipfile.find_entry(mobileprovision_path)

			raise "Embedded mobile provisioning file not found in (#{@ipa_path}) at path (#{mobileprovision_path})" unless mobileprovision_entry
			result[:path_in_ipa] = "#{mobileprovision_entry}"

			tempfile = Tempfile.new(::File.basename(mobileprovision_entry.name))
			begin
				@ipa_zipfile.extract(mobileprovision_entry, tempfile.path){ override = true }
				plist = Plist::parse_xml(`security cms -D -i #{tempfile.path}`)

				plist.each do |key, value|
					next if key == "DeveloperCertificates"

					parse_value = nil
					case value
					when Hash
						parse_value = value
					when Array
						parse_value = value
					else
						parse_value = value.to_s
					end

					result[:content][key] = parse_value
				end

			rescue => e
				puts e.message
				result = nil
			ensure
				tempfile.close and tempfile.unlink
			end
			return result
		end

		def collect_info_plist_info
			raise "IPA is not open" unless self.open?

			result = {
				path_in_ipa: nil,
				content: {}
			}
			info_plist_entry = @ipa_zipfile.find_entry("#{@app_folder_path}/Info.plist")

			raise "File 'Info.plist' not found in #{@ipa_path}" unless info_plist_entry
			result[:path_in_ipa] = "#{info_plist_entry}"

			tempfile = Tempfile.new(::File.basename(info_plist_entry.name))
			begin
				@ipa_zipfile.extract(info_plist_entry, tempfile.path){ override = true }
				# convert from binary Plist to XML Plist
				unless system("plutil -convert xml1 '#{tempfile.path}'")
					raise "Failed to convert binary Plist to XML"
				end
				plist = Plist::parse_xml(tempfile.path)

				plist.each do |key, value|
					parse_value = nil
					case value
					when Hash
						parse_value = value
					when Array
						parse_value = value
					else
						parse_value = value.to_s
					end

					result[:content][key] = parse_value
				end

			rescue => e
				puts e.message
				result = nil
			ensure
				tempfile.close and tempfile.unlink
			end
			return result
		end


		private
		#
		# Find the .app folder which contains both the "embedded.mobileprovision"
		#  and "Info.plist" files.
		def find_app_folder_in_ipa
			raise "IPA is not open" unless self.open?

			# Check the most common location
			app_folder_in_ipa = "Payload/#{File.basename(@ipa_path, File.extname(@ipa_path))}.app"
			#
			mobileprovision_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/embedded.mobileprovision")
			info_plist_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/Info.plist")
			#
			if !mobileprovision_entry.nil? and !info_plist_entry.nil?
				return app_folder_in_ipa
			end

			# It's somewhere else - let's find it!
			@ipa_zipfile.dir.entries("Payload").each do |dir_entry|
				if dir_entry =~ /.app$/
					app_folder_in_ipa = "Payload/#{dir_entry}"
					mobileprovision_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/embedded.mobileprovision")
					info_plist_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/Info.plist")

					if !mobileprovision_entry.nil? and !info_plist_entry.nil?
						break
					end
				end
			end

			if !mobileprovision_entry.nil? and !info_plist_entry.nil?
				return app_folder_in_ipa
			end
			return nil
		end
	end
end