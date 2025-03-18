require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'selenium-webdriver'

# Configuración de Capybara con Selenium
Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server = :puma, { Silent: true }
Capybara.default_max_wait_time = 5  # Aumenta el tiempo de espera

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.args << '--start-maximized'
  options.add_option('slowmo', 500)
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Verificar y mantener el esquema de la base de datos de pruebas
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!
end
