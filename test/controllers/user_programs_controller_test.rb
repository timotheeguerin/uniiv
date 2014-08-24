require 'test_helper'

class UserProgramsControllerTest < ActionController::TestCase

  def setup
    @ability.can :edit, @user
  end

  test 'new should redirect if user faculty is nil ' do
    @user.faculty = nil
    @user.save
    get :new
    assert_response :redirect
  end

  test 'should get new' do
    @user.faculty = create(:faculty)
    @user.save
    get :new
    assert_response :success
  end

  test 'should get select version' do
    get :select_version
    assert_response :success
  end

  test 'should create a new user program' do
    version = create(:program_version)
    program = version.program
    get :create, :program_id => program.id, :version_id => version.id
    assert_response :redirect
    assert @user.taking_program_version?(version)
  end

  test 'should remove user program' do
    version = create(:program_version)
    @user.main_course_scenario.programs << version
    @user.save

    get :delete, :version_id => version.id
    assert_response :redirect
    assert_not @user.taking_program_version?(version)
  end

  test 'should remove user program by program' do
    version = create(:program_version)
    @user.main_course_scenario.programs << version
    @user.save

    get :delete, :program_id => version.program.id
    assert_response :redirect
    assert_not @user.taking_program_version?(version)
  end
  test 'should not remove user program if params missing' do
    version = create(:program_version)
    @user.main_course_scenario.programs << version
    @user.save
    assert_raise ActiveRecord::RecordNotFound do
      get :delete
      assert @user.taking_program_version?(version)
    end
  end
end