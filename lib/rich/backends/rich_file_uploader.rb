# encoding: utf-8

class RichFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::Video  # for your video processing
  include CarrierWave::Video::Thumbnailer

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  Rich.image_styles.each do |name,size|
    version name, if: :image? do
      process resize_to_fit: size.gsub("#", "").split("x").map(&:to_i)
    end
  end

  version :rich_thumb, if: :image? do
    process resize_to_fit: [100, 100]
  end

  version :video_thumb, if: :video? do
    process thumbnail: [{ format: 'png', quality: 10, size: 192, strip: true, logger: Rails.logger }]
    def full_filename(for_file)
      png_name(for_file, version_name)
    end
  end

  # https://github.com/carrierwaveuploader/carrierwave/pull/691
  # version :file_thumb, if: :file? do
  #   process generate_file_thumb(:png)
  # end

  # version :rich_file
  # process encode_video: [:mp4], if: :video?

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def self.extension_white_list
    [
      self.file_extension_white_list,
      self.image_extension_white_list,
      self.video_extension_white_list,
    ].flatten
  end

  def self.file_extension_white_list
    %w(pdf)
  end

  def self.image_extension_white_list
    %w(jpg jpeg gif png)
  end

  def self.video_extension_white_list
    %w(mp4)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

protected
  def generate_file_thumb(format)
    manipulate! do |img| # this is ::MiniMagick::Image instance
      img.format(format.to_s.downcase, 0)
      img
    end
    # manipulate! do |frame, index|
    #   frame if index.zero?
    # end
  end

  def file?(new_file)
    self.class.file_extension_white_list.any? {|ext|
      ext.in?(new_file.content_type)
    }
  end

  def format(format, page = 0)
    @info.clear

    if @tempfile
      new_tempfile = MiniMagick::Utilities.tempfile(".#{format}")
      new_path = new_tempfile.path
    else
      new_path = path.sub(/\.\w+$/, ".#{format}")
    end

    MiniMagick::Tool::Convert.new do |convert|
      convert << (page ? "#{path}[#{page}]" : path)
      yield convert if block_given?
      convert << new_path
    end
  end

  def image?(new_file)
    # new_file.content_type.start_with?('image')
    self.class.image_extension_white_list.any? {|ext|
      ext.in?(new_file.content_type)
    }
  end

  def png_name(for_file, version_name)
    # %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
    %Q{#{version_name}.png}
  end

  def video?(new_file)
    # new_file.content_type.start_with?('video')
    self.class.video_extension_white_list.any? {|ext|
      ext.in?(new_file.content_type)
    }
  end

end
