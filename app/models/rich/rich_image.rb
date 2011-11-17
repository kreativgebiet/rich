require 'cgi'
require 'mime/types'

module Rich
  class RichImage < ActiveRecord::Base
    
    paginates_per 27
    
    has_attached_file :image
    
    validates_attachment_presence :image
    validate :check_content_type    
    validates_attachment_size :image, :less_than=>15.megabyte, :message => "must be smaller than 15MB"
    
    after_initialize :init_styles
    before_create :clean_file_name

    after_create :cache_style_uris_and_save
    before_update :cache_style_uris

    def init_styles
      self.class.has_attached_file :image,
        :styles => hash = Rich.image_styles
    end
    
    private 
    
    def cache_style_uris_and_save
      cache_style_uris
      self.save!
    end
    
    def cache_style_uris
      uris = {}
      
      image.styles.each do |style|
        uris[style[0]] = image.url(style[0].to_sym)
      end
      
      # manualy add the original size
      uris["original"] = image.url(:original)
      
      self.uri_cache = uris.to_json
    end
    
    def clean_file_name
      extension = File.extname(image_file_name).gsub(/^\.+/, '')
      filename = image_file_name.gsub(/\.#{extension}$/, '')
      
      filename = CGI::unescape(filename)
      filename = CGI::unescape(filename)
      
      extension = extension.downcase
      filename = filename.downcase.gsub(/[^a-z0-9]+/i, '-')
      
      self.image.instance_write(:file_name, "#{filename}.#{extension}")
    end
    
    def check_content_type
      self.image.instance_write(:content_type, MIME::Types.type_for(image_file_name)[0])
      logger.debug(image_content_type)
      unless ['image/jpeg', 'image/png', 'image/gif', 'image/jpg'].include?(image_content_type)
        self.errors[:base] << "'#{self.image_file_name}' is not an image."
      end
    end
    
  end
end
