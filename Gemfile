source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass', '3.3.7'
gem 'bcrypt', '3.1.11'
gem 'jquery-rails'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'mysql2'

group :development, :test do
  gem 'listen'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'rspec-rails', '~> 3.6'
  gem 'rspec-parameterized', require: false
  gem 'rspec-json_matcher', require: false
  gem 'database_rewinder'
  gem "factory_bot_rails", require: false
  gem 'shoulda-matchers'
end
