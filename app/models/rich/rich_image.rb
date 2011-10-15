module Rich
  class RichImage < ActiveRecord::Base
    
    #has_attached_file :image, :styles => { :thumb => "100x100#", :large => "1000x1000"}
    has_attached_file :image
    
    validates_attachment_presence :image
    #validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/jpg'], :message => "invalid filetype"
    validates_attachment_size :image, :less_than=>15.megabyte, :message => "must be smaller than 15MB"
    
    after_initialize :init_styles
    
    before_post_process :transliterate_file_name

    def style_uris
     uris = {}
  
      image.styles.each do |style|
        uris[style[0]] = image.url(style[0].to_sym)
      end
      
      # manualy add the original size
      uris["original"] = image.url(:original)
      
      uris.to_json
    end

    def init_styles
      self.class.has_attached_file :image,
        :styles => hash = Rich.image_styles
    end
    
    private 
    
    def transliterate_file_name
      extension = File.extname(image_file_name).gsub(/^\.+/, '')
      filename = image_file_name.gsub(/\.#{extension}$/, '')
      
      # TODO: remove %20 stuff from filename
      
      self.image.instance_write(:file_name, "#{self.transliterate(filename)}.#{self.transliterate(extension)}")
    end
    
    def transliterate(str)
      # Based on permalink_fu by Rick Olsen

      # Escape str by transliterating to UTF-8 with Iconv
      s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s

      # Downcase string
      s.downcase!

      # Remove apostrophes so isn't changes to isnt
      s.gsub!(/'/, '')

      # Replace any non-letter or non-number character with a space
      s.gsub!(/[^A-Za-z0-9]+/, ' ')

      # Remove spaces from beginning and end of string
      s.strip!

      # Replace groups of spaces with single hyphen
      s.gsub!(/\ +/, '-')

      return s
    end
    
    
    
  end
end
