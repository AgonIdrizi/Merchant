options = Selenium::WebDriver::Chrome::Options.new(args: ["headless"])
Capybara.app_host = 'http://localhost:3000'
Capybara.run_server = false

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
  
end
