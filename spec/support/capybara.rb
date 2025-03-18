require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_option(:w3c, false) # Evita errores de "unknown command"

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium
