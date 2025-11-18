require "capybara/rspec"

ENV["SE_DOWNLOAD"] = "false"
ENV["SE_OPTS"] = "--disable-driver-download --disable-build-check"
Selenium::WebDriver.logger.ignore(:webdriver_manager)

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.binary = "/usr/bin/google-chrome"

  options.add_argument("--headless=new")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-software-rasterizer")
  options.add_argument("--remote-debugging-port=9222")

  Selenium::WebDriver::Chrome::Service.driver_path =
    "/usr/local/bin/chromedriver"

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome_headless
