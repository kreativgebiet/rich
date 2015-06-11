require 'fileutils'

desc "Create nondigest versions of all ckeditor digest assets"
task "assets:precompile" do
  fingerprint = /\-[0-9a-f]{32}\.|\-[0-9a-f]{64}\./
  for file in Dir["public/assets/ckeditor/**/*"]
    next unless file =~ fingerprint
    nondigest = file.sub fingerprint, '.'
    FileUtils.cp file, nondigest, verbose: true
  end
end

namespace :rich do

  desc "Re-generate image styles"
  task :refresh_assets => :environment do
    # re-generate images
    ENV['CLASS'] = "Rich::RichFile"
    Rake::Task["paperclip:refresh"].invoke

    # re-generate uri cache
    Rich::RichFile.find_each(&:save)
  end
end
