ActiveAdmin.register Post do
  
  form do |f|
    f.inputs "Basic info" do
      f.input :title
      f.input :content, :as => :rich
    end
    f.buttons
  end
  
end
