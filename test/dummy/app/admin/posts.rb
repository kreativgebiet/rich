ActiveAdmin.register Post do
  
  form do |f|
    f.inputs "Basic info" do
      f.input :title, :as => :rich_picker, :config => { :style => 'width: 400px !important;' }
      f.input :content, :as => :rich
    end
    f.buttons
  end
  
end
