= Rich
------

This project is incomplete and non-functional.

This project rocks and uses MIT-LICENSE.

= Installation
--------------

1- Add following line to Gemfile:

gem 'rich', :git => 'https://github.com/bastiaanterhorst/rich.git'

2- bundle install

3- a) Add js inclusion at the end of your /config/initializers/active_admin file:
config.register_javascript 'rich/base'

3- b) Or just include the file in any page you like, the rails way,
//= require rich/base

4- Add the following to your routes.rb file:
mount Rich::Engine => "/rich" 

5- Then run the following command:
rake rich:install:migrations

6- rake db:migrate

7- Copy config/initializers/rich.rb to your own app's initializers folder.