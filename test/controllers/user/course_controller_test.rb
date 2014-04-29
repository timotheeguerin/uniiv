require 'test_helper'

class User::CourseControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'Should uncomplete course' do
    user_completed_course = create(:user_completed_course)
    @user = user_completed_course.user
    course = user_completed_course.course
    @ability.can :edit, @user
    sign_in @user
    get :remove, :course_id => course.id

    assert (not @user.has_completed_course?(course)), 'User should NOT have completed the course'
    sign_out @user
  end

  test 'Should untake course' do
    user_taking_course = create(:user_taking_course)
    scenario = user_taking_course.course_scenario
    @user = scenario.user
    @ability.can :edit, @user
    course = user_taking_course.course
    sign_in @user
    get :remove, :course_id => course.id

    assert (not scenario.is_taking_course?(course)), 'User should NOT have completed the course'
    sign_out @user
  end
end
