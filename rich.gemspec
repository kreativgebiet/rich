$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rich/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rich"
  s.version     = Rich::VERSION
  s.authors     = ["Bastiaan Terhorst"]
  s.email       = ["bastiaan@perceptor.nl"]
  s.homepage    = "https://github.com/bastiaanterhorst/rich"
  s.summary     = "Rich is an opinionated WYSIWYG editor for Rails based on CKEditor."
  s.description = ""

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "paperclip"
  s.add_dependency "rack-raw-upload"
  s.add_dependency "sass-rails"
  s.add_dependency "mime-types"
  s.add_dependency "kaminari"

  s.add_development_dependency "sqlite3"
  
end
