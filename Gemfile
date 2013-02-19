source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'
gem 'debugger'

gem 'pg'


gem 'capistrano'
gem 'unicorn'

gem 'jquery-rails'
gem 'chosen-rails'
gem 'bcrypt-ruby'

gem 'omniauth-google-oauth2'
gem 'cancan'

gem 'simple_form'
gem 'paper_trail', '~> 2'

gem 'mini_magick'
gem 'carrierwave'
gem 'prawn', git: 'git://github.com/prawnpdf/prawn', branch: 'master'
gem 'rubyzip'

gem 'sidekiq'

# somehow this is needed for deployment
gem 'libv8', '~> 3.11.8'
gem 'therubyracer'

group :development do 
  gem 'thin'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'

  gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
  gem 'jquery-ui-rails'
end

gem 'rspec-rails', group: [:test, :development]

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'

  gem 'rb-inotify', '~> 0.8.8'
  gem 'libnotify'
  gem 'guard-rspec'
end
