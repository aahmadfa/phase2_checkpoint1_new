# # require 'simplecov'
# # SimpleCov.start 'rails' do
# #   add_filter "lib/tasks/"
# #   add_filter "lib/helpers/"
# #   add_filter "lib/filters/"
# #   add_filter "lib/exceptions.rb"
# #   add_filter "app/channels/application_cable/"
# #   add_filter "app/jobs/"
# #   add_filter "app/mailers/"
# #   add_filter "app/controllers/"
# # end
# # ENV['RAILS_ENV'] ||= 'test'
# # require_relative '../config/environment'
# # require 'rails/test_help'
# # require "minitest"
# # require 'minitest/rails'
# # require 'minitest/reporters'
# # require 'minitest_extensions'
# # require 'contexts'


# # class ActiveSupport::TestCase
# #   # Run tests in parallel with specified workers
# #   # Commented out b/c screwing with reporter
# #   # parallelize(workers: :number_of_processors)

# #   # Configure shoulda matchers
# #   Shoulda::Matchers.configure do |config|
# #     config.integrate do |with|
# #       with.test_framework :minitest
# #       with.library :rails
# #     end
# #   end



# #   # Add the infamous deny method...
# #   def deny(condition, msg="")
# #     # a simple transformation to increase readability IMO
# #     assert !condition, msg
# #   end

# #   # Spruce up minitest results...
# #   Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
# # end


# # SimpleCov ...
# require 'simplecov'
# SimpleCov.start 'rails' do
#   add_filter "lib/tasks/"
#   add_filter "lib/helpers/"
#   add_filter "lib/filters/"
#   add_filter "lib/exceptions.rb"
#   add_filter "app/channels/application_cable/"
#   add_filter "app/jobs/"
#   add_filter "app/mailers/"
#   add_filter "app/controllers/"
# end


# ENV["RAILS_ENV"] ||= "test"
# require_relative '../config/environment'
# require 'rails/test_help'
# require "minitest"
# require 'minitest/rails'
# require 'minitest/reporters'
# require 'minitest_extensions'
# require 'contexts'

# class ActiveSupport::TestCase
#   # Run tests in parallel with specified workers
#   # Commented out b/c screwing with reporter
#   # parallelize(workers: :number_of_processors)

#   # Configure shoulda matchers
#   Shoulda::Matchers.configure do |config|
#     config.integrate do |with|
#       with.test_framework :minitest
#       with.library :rails
#     end
#   end

#   # Add more helper methods to be used by all tests here...
#   include Contexts

#   # Add the infamous deny method...
#   def deny(condition, msg="")
#     # a simple transformation to increase readability IMO
#     assert !condition, msg
#   end

#   # Spruce up minitest results...
#   Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
# end


require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest"
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest_extensions'
require 'contexts'


class ActiveSupport::TestCase
  # Since we are not using fixtures, comment this line out...
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include Contexts

  # Add the infamous deny method...
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end

  # Spruce up minitest results...
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end

end #end of the class