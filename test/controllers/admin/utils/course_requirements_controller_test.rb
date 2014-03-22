require 'test_helper'

class Admin::Utils::CourseRequirementsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @ability.can :manage, :admin_utils
  end


  test 'should get index' do
    assert_response :success
  end


  test 'mark as none prerequisite' do
    req =  Admin::CourseRequirementFilled.create!(:prerequisites=> false)
    get :mark_as_none, :id => req.id, :type => 'prerequisite'
    assert_response :redirect
    req.reload
    assert req.prerequisites?, 'Prerequisite should have been filled to true'
  end

  test 'mark as none corequisite' do
    req =  Admin::CourseRequirementFilled.create!(:corequisites=> false)
    get :mark_as_none, :id => req.id, :type => 'corequisites'
    assert_response :redirect
    req.reload
    assert req.corequisites?, 'Corequisite should have been filled to true'
  end

=begin
  test 'should get input requirement' do
    req =  Admin::CourseRequirementFilled.create!()
    get :input_requirement, :id => req.id
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
