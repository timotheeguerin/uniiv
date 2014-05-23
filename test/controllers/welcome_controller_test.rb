require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'Should redirect when sign in' do
    user = create(:user)
    sign_in user
    get :index
    assert_response :redirect
    sign_out user
  end
end
