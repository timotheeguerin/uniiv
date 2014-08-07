require 'test_helper'

class Utils::FinalGradeCalculatorControllerTest < ActionController::TestCase
  tests Utils::FinalGradeCalculatorController
  include Devise::TestHelpers

  test 'should get index' do
    @ability.can :read, :fgc
    get :index
    assert_response :success
  end

  test 'should get show' do
    @ability.can :read, :fgc
    course = create(:course_course)
    assert_difference '@user.fgc_predictions.size' do
      get :show, :id => course.id
      assert_response :success
      @user.reload

    end
  end

  test 'should create a grade' do
    @ability.can :read, :fgc
    prediction = create(:fgc_prediction, :user => @user)
    assert_difference 'prediction.groups.size' do
      get :create_grade, :id => prediction.course.id
      assert_response :redirect
      prediction.reload
    end
  end

  test 'should edit a grade value' do
    @ability.can :read, :fgc
    prediction = create(:fgc_prediction, :user => @user)
    grade = create(:fgc_grade, :prediction => prediction)
    grade.value = 0
    get :edit_grade_value, :id => grade.group.prediction.course.id, :grade => grade.id, :value => 10
    assert_response :success
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    grade.reload

    assert grade.value == 10
  end

  test 'should edit a grade name' do
    @ability.can :read, :fgc
    prediction = create(:fgc_prediction, :user => @user)
    grade = create(:fgc_grade, :prediction => prediction)
    grade.name = 'oldname'
    get :edit_grade_name, :id => grade.group.prediction.course.id, :grade => grade.id, :name => 'new name'
    assert_response :success
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{@response.body}"
    grade.reload
    assert grade.name == 'new name'
  end
end