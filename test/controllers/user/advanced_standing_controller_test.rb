require 'test_helper'

class User::AdvancedStandingControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get index' do
    @user = users(:simple_user)
    sign_in @user
    @ability.can :edit, @user
    get :index
    assert_response :success
  end

  test 'Setting credit' do
    @user = users(:simple_user)
    @ability.can :edit, @user
    sign_in @user
    @user.advanced_standing_credits = 10
    get :set_credit, :advanced_standing_credit => 20
    @user.reload
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    assert @user.advanced_standing_credits == 20, "Advanced standing should be 20 but are #{@user.advanced_standing_credits}"
    sign_out @user
  end

  test 'Should add a new advanced standing' do
    @user = users(:simple_user)
    @ability.can :edit, @user
    course = course_courses(:simple_course)
    sign_in @user

    get :create, :course_id => course.id
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    assert @user.has_completed_course?(course), 'User should have completed the course'
    @user.completed_courses.destroy_all
    sign_out @user
  end

  test 'Should remove the advanced standing' do
    @user = users(:simple_user)
    @ability.can :edit, @user
    course = course_courses(:simple_course)
    UserCompletedCourse.create!(:user => @user, :course => course, :advanced_standing => true)
    sign_in @user
    get :remove, :course_id => course.id
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    assert (not @user.has_completed_course?(course)), 'User should NOT have completed the course'
    sign_out @user
  end

end
