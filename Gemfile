source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# gem for devise and jwt
gem 'devise'
gem 'devise-jwt'
gem 'rack-cors'

# webpacker gem
gem 'webpacker', '~> 5.x'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dalli'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'cancancan'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
   gem 'rspec-rails'
   gem 'factory_girl_rails'
   gem 'rspec-json_expectations'
   gem 'faker', '~> 1.9.5'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  
  #  devise for background jobs
  gem 'spring'
  gem 'mail' # gem for mails
  gem 'sidekiq' #sidekiq
  gem "letter_opener" #mail preview
  gem 'capistrano-sidekiq'
  # gem 'image_processing', '~> 1.2' #for image processing
end
#gem for production
# group :production do
#   gem 'pg'
# end
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'stripe' 

group :test do 
 gem 'database_cleaner'
end

group :production do
  gem 'pg'
 
end

