# == Assetize CKEditor
#
# This rake taks copies all CKEditor files from <tt>/vendor</tt> 
# to <tt>/public/assets/</tt>. Required when running Rich in production mode.
namespace :rich do
  
  desc "Copy CKEditor files to /public/assets for production"
  task :assetize_ckeditor do
    puts "Rich - Copying CKEditor to your assets folder"
    
    mkdir_p Rails.root.join('public/assets/ckeditor')
    cp_r Rich::Engine.root.join('vendor/assets/ckeditor/ckeditor/.'), Rails.root.join('public/assets/ckeditor')
    
    mkdir_p Rails.root.join('public/assets/ckeditor-contrib')
    cp_r Rich::Engine.root.join('vendor/assets/ckeditor/ckeditor-contrib/.'), Rails.root.join('public/assets/ckeditor-contrib')
    
  end
  
  desc "Clear CKEditor files from /public/assets"
  task :clean_ckeditor do
    puts "Rich - Removing CKEditor from your assets folder"
    begin
      rm_r Rails.root.join('public/assets/ckeditor')
      rm_r Rails.root.join('public/assets/ckeditor-contrib')
    rescue
      # the folder may not exist
    end
  end
  
  desc "Re-generate image styles"
  task :refresh_assets => :environment do
    # re-generate images
    ENV['CLASS'] = "Rich::RichFile"
    Rake::Task["paperclip:refresh"].invoke
    
    # re-generate uri cache
    Rich::RichFile.find_each(&:save)
  end
end

# Hook to automatically assetize ckeditor when precompiling assets
namespace :assets do
  task :precompile => 'rich:assetize_ckeditor'
  task :clean => 'rich:clean_ckeditor'
end