require 'test_helper'

class UserFacultyControllerTest < ActionController::TestCase
  test 'should not get edit without permission' do
    assert_raise CanCan::AccessDenied do
      get :edit
    end
  end

  test ' should reirect if user university is not defined ' do
    @ability.can :edit, @user
    @user.university = nil
    @user.save
    get :edit
    assert_response :redirect
  end

  test 'should show edit' do
    @ability.can :edit, @user
    get :edit
    assert_response :success
  end

  test 'should not update without permission' do
    assert_raise CanCan::AccessDenied do
      get :update
    end
  end

  test 'should update user faculty' do
    @ability.can :edit, @user
    faculty = create(:faculty)
    get :update, faculty_id: faculty.id
    assert_response :redirect

    @user.reload
    assert_equal @user.faculty, faculty
  end
end
