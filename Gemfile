source 'https://rubygems.org'
gem 'rails', '3.2.8'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'activeadmin'
gem 'whenever', :require => false
gem 'jquery-rails'
gem 'unicorn', '>= 4.3.1'
gem 'bootstrap-sass', '>= 2.1.1.0'
gem 'inherited_resources'
gem 'has_scope'
gem 'devise', '>= 2.1.2'
gem 'pg', '>= 0.14.1'
gem 'haml', '>= 3.1.7'
gem 'haml-rails', '>= 0.3.5', :group => :development
gem 'hpricot', '>= 0.8.6', :group => :development
gem 'ruby_parser', '>= 3.1.0', :group => :development
gem 'quiet_assets', '>= 1.0.1', :group => :development
gem 'figaro', '>= 0.5.0'
gem 'better_errors', '>= 0.2.0', :group => :development
gem 'binding_of_caller', '>= 0.6.8', :group => :development
gem 'hub', '>= 1.10.2', :require => nil, :group => [:development]
gem 'feedzirra'

gem 'flajax', :git => 'https://github.com/bonzofenix/flajax.git'

# For authentication with twitter and google 
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'

group :development do
  gem 'taps', require: false
  gem 'sqlite3'
end

group :test, :development do
  gem 'sqlite3-ruby'
  gem 'rspec-rails', '>= 2.11.4'
  gem 'letter_opener'
  gem 'factory_girl_rails', '>= 4.1.0'
  gem 'email_spec', '>= 1.4.0', :group => :test
  gem 'debugger'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit', :git => 'https://github.com/thoughtbot/capybara-webkit.git'
  gem 'database_cleaner', '>= 0.9.1', :group => :test
end
