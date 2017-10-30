source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.4'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'carrierwave',             '1.1.0'
gem 'mini_magick',             '4.7.0'
gem 'fog',                     '1.40.0'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'sprockets-rails', :require => 'sprockets/railtie'

# gem 'bootstrap', '~> 4.0.0.beta'
# gem 'jquery-rails'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
#To make the password digest, has_secure_password uses a state-of-the-art hash function called bcrypt.
gem 'bcrypt', '~> 3.1.11'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'sqlite3' 
  gem 'web-console', '>= 3.3.0'
end

group :production do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'pg' 
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#Sending emails using ActionMailer and Mailgun through Mailgun’s APIs

gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'
gem 'delayed_job_active_record'
gem 'acts_as_votable', '~> 0.10.0'
gem 'record_tag_helper', '~> 1.0'
gem "font-awesome-rails"