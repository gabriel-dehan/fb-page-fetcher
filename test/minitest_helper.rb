require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/spec'
require 'minitest/matchers'

require 'minitest/rails'
require 'minitest/rails/shoulda'
require 'minitest/rails/capybara'

require 'minitest/autorun'
require 'minitest-metadata'

require 'mocha/setup'

require 'turn/autorun'
require 'capybara/poltergeist'

# Turn.config.format = :cue
Turn.config.format = :pretty
Capybara.javascript_driver = :poltergeist

class MiniTest::Rails::ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class MiniTest::Spec
  class << self
    alias :its :it
  end

  # Will switch the driver from rack_test to poltergeist, for every `it` block
  # with the option { js: true } set.
  # Requires 'minitest-metadata'.
  #
  # Returns Nothing.
  def switch_drivers
    if metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver if Capybara.current_driver != Capybara.javascript_driver
    else
      Capybara.current_driver = Capybara.default_driver if Capybara.current_driver != Capybara.default_driver
    end
  end

  # Switch the drivers before each test (might slow down the tests, it should be optimized)
  def setup
    switch_drivers
    Facebook.stubs(:connect).returns('poney')
  end
end

MiniTest::Rails.override_testunit!
