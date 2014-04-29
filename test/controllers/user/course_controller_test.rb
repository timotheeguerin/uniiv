require 'test_helper'

class User::CourseControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'Should show completed course' do
    @user = create(:user)
    course = create(:course_course)
    @ability.can :edit, @user
    sign_in @user
    get :complete_show, :course_id => course.id
    sign_out @user
  end

  test 'Should complete course' do
    @user = create(:user)
    @ability.can :edit, @user
    sign_in @user

    course = create(:course_course)
    semester = create(:course_semester)
    grade = create(:course_grading_system_entity)

    get :complete_create, :course_id => course.id,
        :user_completed_course => {:semester_id => semester.id, :year => 2014, :grade_id => grade.id}
    assert_response :redirect
    assert @user.has_completed_course?(course), 'User should have completed the course'
    sign_out @user
  end

  test 'Should complete currenty taking course' do
    @user = create(:user)
    @ability.can :edit, @user
    sign_in @user

    user_taking_course = create(:user_taking_course)
    scenario = user_taking_course.course_scenario

    course = user_taking_course.course
    grade = create(:course_grading_system_entity)

    get :complete_create, :course_id => course.id,
        :user_completed_course => {:semester_id => user_taking_course.semester.id,
                                   :year => user_taking_course.year, :grade_id => grade.id}
    assert_response :redirect
    assert @user.has_completed_course?(course), 'User should have completed the course'
    assert (not scenario.is_taking_course?(course)), 'User should NOT be taking the course'
    sign_out @user
  end

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

    assert (not scenario.is_taking_course?(course)), 'User should NOT be taking the course'
    sign_out @user
  end
end
