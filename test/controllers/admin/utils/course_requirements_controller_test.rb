require 'test_helper'

class Admin::Utils::CourseRequirementsControllerTest < ActionController::TestCase
  include Devise::TestHelpers


  test 'should get index' do
    @ability.can :manage, :admin_utils
    assert_response :success
  end
=begin

  test 'should get mark as none' do
    get :mark_as_none
    assert_response :success
  end

  test 'should get input requirement' do
    get :input_requirement
    assert_response :success
  end

  test 'should get subject_input_requirement' do
    get :subject_input_requirement
    assert_response :success
  end

  test 'should get save_requirement' do
    get :save_requirement
    assert_response :success
  end
  test 'should get get_subject_requirement_params' do
    get :save_requirement
    assert_response :success
  end
=end

end
