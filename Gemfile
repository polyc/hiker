source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# use Haml for templates
gem 'haml'
#Use Bcrypt for password encryption
gem 'bcrypt-ruby', :require => 'bcrypt'
# Use OmniAuth for third party authentication
gem 'omniauth-facebook'
#Use Devise for third-party auth
gem 'devise', '~> 4.7'
# Use Geocoder gem for handling space coordinates
gem 'geocoder'
#Use polyline to draw path on gmaps
gem 'polylines'
#Use mini_magick and carrierwave for image upload
gem 'mini_magick'
gem 'carrierwave'

gem 'gon'
gem 'rmagick'


# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
#turbolinks
gem 'turbolinks', '~> 5'
# Use jquery
gem 'jquery-rails'
#bootstrap css
gem 'bootstrap-sass'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
#Use will_paginate gem for paginated views
gem 'will_paginate', '~> 3.1.0'
gem 'bootstrap-will_paginate'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'jasmine-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


group :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'selenium-webdriver'
end
