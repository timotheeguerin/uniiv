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
    req = Admin::CourseRequirementFilled.create!(:prerequisites => false)
    get :mark_as_none, :id => req.id, :type => 'prerequisite'
    assert_response :redirect
    req.reload
    assert req.prerequisites?, 'Prerequisite should have been filled to true'
  end

  test 'mark as none corequisite' do
    req = Admin::CourseRequirementFilled.create!(:corequisites => false)
    get :mark_as_none, :id => req.id, :type => 'corequisites'
    assert_response :redirect
    req.reload
    assert req.corequisites?, 'Corequisite should have been filled to true'
  end


  test 'Test get input requirements with prerequisite' do
    req = admin_course_requirement_filleds(:with_prerequisite)
    get :input_requirement, :id => req.id, :type => 'prerequisite'
    assert_response :success
  end

  test 'Test get input requirements without prerequisite' do
    req = admin_course_requirement_filleds(:without_prerequisite)
    get :input_requirement, :id => req.id, :type => 'prerequisite'
    assert_response :success
  end

  test 'Test get input requirements with corequisite' do
    req = admin_course_requirement_filleds(:with_corequisite)
    get :input_requirement, :id => req.id, :type => 'corequisite'
    assert_response :success
  end

  test 'Test get input requirements without corequisite' do
    req = admin_course_requirement_filleds(:without_corequisite)
    get :input_requirement, :id => req.id, :type => 'corequisite'
    assert_response :success
  end

  test 'should get subject_input_requirement' do
    req = admin_course_requirement_filleds(:simple)
    get :subject_input_requirement, :id => req.id
    assert_response :success
  end

  test 'should save prerequisite' do
    subject = course_subjects(:default)
    course = Course::Course.create!(:name => 'Tmp course', :credit => 3, :hours => 3, :description => 'Empty desc', :subject=> subject, :code => 1234)
    req = Admin::CourseRequirementFilled.find_by_course_id(course.id)
    get :save_requirement, :id => req.id, :type => 'prerequisite'
    assert_response :redirect
    course.destroy #Cleanup so we can reusse the code
  end

end
