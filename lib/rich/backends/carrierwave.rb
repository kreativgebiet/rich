raise "Please install CarrierWave: github.com/carrierwaveuploader/carrierwave" unless Object.const_defined?(:CarrierWave)
require 'rich/utils/file_size_validator'
require 'rich/backends/rich_file_uploader'

module Rich
  module Backends
    module CarrierWave
      extend ActiveSupport::Concern

      included do
        mount_uploader :rich_file_file_name, RichFileUploader

        before_validation :update_rich_file_attributes

        validate :check_content_type
        validates :rich_file_file_name,
          :presence => true,
          :file_size => {
            :maximum => 15.megabytes.to_i
          }

        after_save :clear_uri_cache
      end

      def rich_file
        self.rich_file_file_name
      end

      def rich_file=(val)
        self.rich_file_file_name = val
      end

      def filename
        rich_file.file.filename
      end

      def uri_cache
        uri_cache_attribute = read_attribute(:uri_cache)
        if uri_cache_attribute.blank?
          uris = {}

          rich_file.versions.each do |version|
            uris[version[0]] = rich_file.url(version[0].to_sym, false)
          end

          # manualy add the original size
          uris["original"] = rich_file.url

          uri_cache_attribute = uris.to_json
          write_attribute(:uri_cache, uri_cache_attribute)
        end
        uri_cache_attribute
      end

      def rename!(new_filename_without_extension)
        new_filename = new_filename_without_extension + '.' + rich_file.file.extension
        rename_files!(new_filename)
        rich_file.model.update_column(:rich_file_file_name, new_filename)
        clear_uri_cache
        new_filename
      end

      private

      def rename_files!(new_filename)
        rename_file!(rich_file, new_filename)
        rich_file.versions.keys.each do |version|
          rename_file!(rich_file.send(version), "#{version}_#{new_filename}")
        end
      end

      def rename_file!(version, new_filename)
        path = version.path
        FileUtils.move path, File.join(File.dirname(path), new_filename)
      end

      def check_content_type
        unless Rich.validate_mime_type(self.rich_file_content_type, self.simplified_type)
          self.errors[:base] << "'#{self.rich_file_file_name}' is not the right type."
        end
      end

      def update_rich_file_attributes
        if rich_file.present? && rich_file_file_name_changed?
          self.rich_file_content_type = rich_file.file.content_type
          self.rich_file_file_size = rich_file.file.size
          self.rich_file_updated_at = Time.now
        end
      end

      def clear_uri_cache
        write_attribute(:uri_cache, nil)
      end

      module ClassMethods

      end
    end
  end

  # Rich::RichFile.send(:include, Backends::CarrierWave)
end
