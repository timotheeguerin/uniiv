require 'test_helper'

class UserDashboardControllerTest < ActionController::TestCase

  def setup
    bypass_rescue
  end

  test 'should not get index without permission' do
    assert_raise CanCan::AccessDenied do
      get :index
    end
  end

  test 'index should redirect if user does not have any program' do
    @ability.can :view, @user
    get :index
    assert_response :redirect
  end

  test 'should get index' do
    @ability.can :view, @user

    @user.main_course_scenario.programs << create(:program_version)
    get :index
    assert_response :success
  end

  test 'should not get selection without permission' do
    assert_raise CanCan::AccessDenied do
      get :selection
    end
  end

  test 'should get selection' do
    @ability.can :view, @user
    get :selection
    assert_response :success
  end

  test 'should not get user_course_taking_content without permission' do
    assert_raise CanCan::AccessDenied do
      get :user_course_taking_content
    end
  end

  test 'should get user_course_taking_content' do
    @ability.can :view, @user
    get :user_course_taking_content
    assert_response :success
  end

  test 'should not get user_course_completed_content without permission' do
    assert_raise CanCan::AccessDenied do
      get :user_course_completed_content
    end
  end

  test 'should get user_course_completed_content' do
    @ability.can :view, @user
    get :user_course_completed_content
    assert_response :success
  end
end
