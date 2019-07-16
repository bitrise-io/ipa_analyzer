# frozen_string_literal: true

require 'tempfile'
require 'zip'
require 'zip/filesystem'
require 'plist'

module IpaAnalyzer
  # Analyzer
  class Analyzer
    def initialize(ipa_path)
      @ipa_path = ipa_path
      @ipa_zipfile = nil
      @app_folder_path = nil
    end

    def open!
      @ipa_zipfile = Zip::File.open(@ipa_path)
      @app_folder_path = find_app_folder_in_ipa
      raise 'No app folder found in the IPA' if @app_folder_path.nil?
    end

    def open?
      return !@ipa_zipfile.nil?
    end

    def close
      @ipa_zipfile.close if self.open?
    end

    def collect_provision_info
      raise 'IPA is not open' unless self.open?

      result = {
        path_in_ipa: nil,
        content: {}
      }
      mobileprovision_path = "#{@app_folder_path}/embedded.mobileprovision"
      mobileprovision_entry = @ipa_zipfile.find_entry(mobileprovision_path)

      raise "Embedded mobile provisioning file not found in (#{@ipa_path}) at path (#{mobileprovision_path})" unless mobileprovision_entry

      result[:path_in_ipa] = mobileprovision_entry.to_s

      tempfile = Tempfile.new(::File.basename(mobileprovision_entry.name))
      begin
        @ipa_zipfile.extract(mobileprovision_entry, tempfile.path) { true }
        plist = Plist.parse_xml(`security cms -D -i #{tempfile.path}`)

        plist.each do |key, value|
          next if key == 'DeveloperCertificates'

          parse_value = value.class == Hash || value.class == Array ? value : value.to_s

          result[:content][key] = parse_value
        end
      rescue StandardError => e
        puts e.message
        result = nil
      ensure
        tempfile.close && tempfile.unlink
      end
      return result
    end

    def collect_info_plist_info
      raise 'IPA is not open' unless self.open?

      result = {
        path_in_ipa: nil,
        content: {}
      }
      info_plist_entry = @ipa_zipfile.find_entry("#{@app_folder_path}/Info.plist")

      raise "File 'Info.plist' not found in #{@ipa_path}" unless info_plist_entry

      result[:path_in_ipa] = info_plist_entry.to_s

      tempfile = Tempfile.new(::File.basename(info_plist_entry.name))
      begin
        @ipa_zipfile.extract(info_plist_entry, tempfile.path) { true }
        # convert from binary Plist to XML Plist
        raise 'Failed to convert binary Plist to XML' unless system("plutil -convert xml1 '#{tempfile.path}'")

        plist = Plist.parse_xml(tempfile.path)

        plist.each do |key, value|
          parse_value = value.class == Hash || value.class == Array ? value : value.to_s

          result[:content][key] = parse_value
        end
      rescue StandardError => e
        puts e.message
        result = nil
      ensure
        tempfile.close && tempfile.unlink
      end
      return result
    end

    private

    #
    # Find the .app folder which contains both the "embedded.mobileprovision"
    #  and "Info.plist" files.
    def find_app_folder_in_ipa
      raise 'IPA is not open' unless self.open?

      # Check the most common location
      app_folder_in_ipa = "Payload/#{File.basename(@ipa_path, File.extname(@ipa_path))}.app"

      mobileprovision_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/embedded.mobileprovision")
      info_plist_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/Info.plist")

      return app_folder_in_ipa if !mobileprovision_entry.nil? && !info_plist_entry.nil?

      # It's somewhere else - let's find it!
      @ipa_zipfile.dir.entries('Payload').each do |dir_entry|
        next unless dir_entry =~ /.app$/

        app_folder_in_ipa = "Payload/#{dir_entry}"
        mobileprovision_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/embedded.mobileprovision")
        info_plist_entry = @ipa_zipfile.find_entry("#{app_folder_in_ipa}/Info.plist")

        break if !mobileprovision_entry.nil? && !info_plist_entry.nil?
      end

      return app_folder_in_ipa if !mobileprovision_entry.nil? && !info_plist_entry.nil?

      return nil
    end
  end
end
