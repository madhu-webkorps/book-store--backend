# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'rspec/json_expectations'
# note: require 'devise' after require 'rspec/rails'
require 'devise'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
  config.include Warden::Test::Helpers, type: :request
  config.include ActiveJob::TestHelper
  # config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  # config.order = "random"

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end