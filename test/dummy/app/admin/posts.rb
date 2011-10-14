ActiveAdmin.register Post do
  
  form do |f|
    f.inputs "Content" do
      f.input :content, :as => :rich
    end
    f.buttons
  end
  
end
