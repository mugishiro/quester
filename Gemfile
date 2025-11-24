source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2.0'

gem 'rails', '~> 7.1.5', '>= 7.1.5.2'

# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.5', group: [:development, :test]
gem 'puma', '~> 5.6'
gem 'sass-rails', '>= 6'
gem 'uglifier', '>= 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'kaminari'
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-rails_csrf_protection'
gem 'twitter'
gem 'dotenv-rails'
gem 'meta-tags'
gem 'mini_magick'
gem 'aws-sdk-s3', require: false
gem 'jquery-rails'
gem 'rails-i18n'
gem 'pg', group: :production

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'rubocop-airbnb'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
