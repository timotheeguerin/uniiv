ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/mock'
require 'mocha'
Dir["#{Rails.root}/lib/**/*.rb"].each do |rb_file|
  require rb_file
end
MiniTest::Reporters.use!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  setup :setup_uniiv

  def setup_uniiv
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
  end
end
