require 'test_helper'

class User::AdvancedStandingControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get index' do
    @ability.can :edit, @user
    get :index
    assert_response :success
  end

  test 'Setting credit' do
    @ability.can :edit, @user
    @user.advanced_standing_credits = 10
    @user.save
    get :set_credit, :advanced_standing_credit => 20
    @user.reload
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    assert @user.advanced_standing_credits == 20, "Advanced standing should be 20 but are #{@user.advanced_standing_credits}"
  end

  test 'Should add a new advanced standing' do
    @ability.can :edit, @user
    course = create(:course_course)

    get :create, :course_id => course.id
    assert_response :success
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    assert @user.has_completed_course?(course), 'User should have completed the course'
  end

  test 'Should remove the advanced standing' do
    @ability.can :edit, @user
    course = create(:course_course)
    UserCompletedCourse.create!(:user => @user, :course => course, :advanced_standing => true)
    get :remove, :course_id => course.id
    assert_response :success
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    assert (not @user.has_completed_course?(course)), 'User should NOT have completed the course'
  end

end
