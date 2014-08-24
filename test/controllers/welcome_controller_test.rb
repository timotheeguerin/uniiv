require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get homepage when not signin' do
    sign_out @user
    get :index
    assert_response :success
    sign_in @user
  end

  test 'Should redirect when sign in' do
    get :index
    assert_response :redirect
  end
end
