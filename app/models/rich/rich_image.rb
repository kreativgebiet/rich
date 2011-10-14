module Rich
  class RichImage < ActiveRecord::Base
    
    #has_attached_file :image, :styles => { :thumb => "100x100#", :large => "1000x1000"}
    has_attached_file :image
    
    validates_attachment_presence :image
    #validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif', 'image/jpg'], :message => "invalid filetype"
    validates_attachment_size :image, :less_than=>15.megabyte, :message => "must be smaller than 15MB"
    
    after_initialize :init_styles
    
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
    
    
  end
end
