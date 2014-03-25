require 'test_helper'

class Utils::FinalGradeCalculatorControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    @user = users(:simple_user)
    sign_in @user
    @ability.can :read, :fgc

    get :index
    assert_response :success
  end

  #test 'should get show' do
  #  @user = users(:simple_user)
  #  sign_in @user
  #  @ability.can :read, :fgc
  #
  #  course = course_courses(:simple_course)
  #  assert_difference '@user.fgc_predictions.size' do
  #    get :show, :id => course.id
  #    assert_response :success
  #  end
  #end
end