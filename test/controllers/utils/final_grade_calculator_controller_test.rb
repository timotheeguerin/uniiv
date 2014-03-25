require 'test_helper'

class Utils::FinalGradeCalculatorControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    @user = create(:user)
    sign_in @user
    @ability.can :read, :fgc
    get :index
    assert_response :success
  end

  test 'should get show' do
    @user = create(:user)
    sign_in @user
    @ability.can :read, :fgc
    course = create(:course_course)
    assert_difference '@user.fgc_predictions.size' do
      get :show, :id => course.id
      assert_response :success
      @user.reload
    end
  end
end