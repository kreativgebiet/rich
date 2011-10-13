# require 'rubygems'
# 
# # Set up gems listed in the Gemfile.
# ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
# 
# require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
# 
# 
 
require 'rubygems'
gemfile = File.expand_path('../../../../Gemfile', __FILE__)
 
if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
end
 
$:.unshift File.expand_path('../../../../lib', __FILE__)