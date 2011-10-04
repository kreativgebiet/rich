module Rich
  class RichImage < ActiveRecord::Base
    has_attached_file :image, :styles => { :thumb=> "100x100#" }
    
    validates_attachment_presence :image
    validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif']
    validates_attachment_size :image, :less_than=>15.megabyte
    
  end
end
