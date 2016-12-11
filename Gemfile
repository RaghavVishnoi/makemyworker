source 'https://rubygems.org'
ruby "2.3.1"

gem 'rails', '4.2.2'
gem 'pg'
#gem 'mysql'

gem 'activerecord-postgis-adapter'
gem 'airbrake', '4.3.3'
gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem 'carrierwave-imageoptimizer'
gem 'carrierwave-processing'
gem 'coffee-rails', '~> 4.1.0'
gem 'devise', '>= 2.0.0', :git => 'git://github.com/plataformatec/devise.git'
gem 'devise_invitable', '~> 1.3.4'
gem 'email_validator'
gem 'flutie'
gem 'foursquare2'
gem 'friendly_id', '~> 5.0.0'
gem 'fog'
gem 'geokit-rails'
gem 'i18n-tasks'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'koala'
gem 'newrelic_rpm'
gem 'paranoia'
gem 'pundit'
gem 'rack-canonical-host'
gem 'rack-cors', :require => 'rack/cors'
gem 'rack-timeout'
gem 'rails_12factor'
gem 'recipient_interceptor'
gem 'rmagick'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'simple_form'
gem 'time_for_a_boolean'
gem 'timezone'
gem 'title'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn'
gem 'versionist'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'

#To use schedular
gem 'rufus-scheduler', '3.0.2'

#To get location
gem 'geocoder'

#To integrate stripe
gem 'stripe'

#To get timezone
gem 'tzinfo', '~> 1.2', '>= 1.2.2'

#To configure push notification
gem 'rpush'

#For authentication
gem 'clearance'

#To calculate time difference
gem 'time_difference'

#For serialization
gem 'active_model_serializers'

#For parse push
gem 'parse-ruby-client', git: 'https://github.com/adelevie/parse-ruby-client.git'

group :development  do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'meta_request'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'awesome_print'
  gem 'bundler-audit', require: false
  gem 'byebug'
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'email_spec'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'seed_dump'
  gem 'letter_opener'
end

group :test do
  #gem 'capybara-webkit', '>= 1.2.0'
  gem 'database_cleaner'
  gem 'faker'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  #gem 'rails_stdout_logging'
end
