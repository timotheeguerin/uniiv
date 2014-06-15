ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/mock'
require 'minitest/unit'
require 'mocha'
Dir["#{Rails.root}/lib/**/*.rb"].each do |rb_file|
  require rb_file
end
MiniTest::Reporters.use!

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods
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
  teardown :teardown_uniiv

  def setup_uniiv
    @user = create(:user)
    sign_in @user
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
    @request.env['HTTP_REFERER'] = '/back'
  end

  def teardown_uniiv
    sign_out @user
  end

  def set_current_scenario(scenario)
    @controller.send(:current_scenario=, scenario)
  end
end
