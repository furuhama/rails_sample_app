source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# bootstrap-sassを追加
gem 'bootstrap-sass', '3.3.7'
# ハッシュ関数を導入するためにbcryptを追加
gem 'bcrypt', '3.1.11'
# bootstrapを動かすためにjquery-railsを入れる
gem 'jquery-rails'
# 疑似データ作成
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
# 画像upload機能のためのgemたち
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
# use mysql for database
gem 'mysql2'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  # テスト用にRSpec利用
  gem 'rspec-rails', '~> 3.6'
  # rspecにて条件を羅列する記述をするため
  gem 'rspec-parameterized', require: false
  # json spec
  gem 'rspec-json_matcher', require: false
  # テストデータ削除
  gem 'database_rewinder'
  # テストデータ作成
  gem "factory_bot_rails", require: false
  # rspecのmatcherの拡張
  gem 'shoulda-matchers'
end
