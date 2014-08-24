require 'test_helper'

class UserSettingsControllerTest < ActionController::TestCase
  test 'should not get index without permission' do
    assert_raise CanCan::AccessDenied do
      get :index
    end
  end

  test 'index show edit' do
    @ability.can :edit, @user
    get :index
    assert_response :success
  end
end
