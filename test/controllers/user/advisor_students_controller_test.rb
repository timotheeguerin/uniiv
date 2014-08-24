require 'test_helper'

class User::AdvisorStudentsControllerTest < ActionController::TestCase
  test 'should not get index without permission' do
    assert_raise CanCan::AccessDenied do
      get :index
    end
  end

  test 'should get index as a student' do
    @ability.can :read, User::AdvisorStudent
    get :index
    assert_response :success
  end

  test 'should get index as a advisor' do
    new_user(:advisor)
    @ability.can :read, User::AdvisorStudent
    get :index
    assert_response :success
  end

  test 'should not get new without permission' do
    assert_raise CanCan::AccessDenied do
      get :new
    end
  end

  test 'should get new with permission' do
    @ability.can :create, User::AdvisorStudent
    get :new
    assert_response :success
  end

  test 'should not get create without permission' do
    assert_raise CanCan::AccessDenied do
      get :new
    end
  end

  test 'should get create as a student' do
    @ability.can :create, User::AdvisorStudent
    advisor = create(:student)
    get :create, user_advisor_student: {student_id: @user.id, advisor_id: advisor.id}
    assert_response :redirect
    assert_equal assigns(:advisor_student).status.to_sym, :requested
  end

  test 'should get create as a advisor' do
    new_user(:advisor)
    student = create(:student)
    @ability.can :create, User::AdvisorStudent
    get :create, user_advisor_student: {student_id: student.id, advisor_id: @user.id}
    assert_response :redirect
    assert_equal assigns(:advisor_student).status.to_sym, :validated
  end

  test 'should not destroy without permission' do
    advisor_student = create(:user_advisor_student)
    assert_raise CanCan::AccessDenied do
      get :destroy, id: advisor_student.id
    end
  end

  test 'should destroy' do
    @ability.can :destroy, User::AdvisorStudent
    advisor_student = create(:user_advisor_student)
    get :destroy, id: advisor_student.id
    assert_response :redirect
  end

  test 'should not update_status without permission' do
    advisor_student = create(:user_advisor_student)
    assert_raise CanCan::AccessDenied do
      get :update_status, id: advisor_student.id
    end
  end

  test 'should update_status' do
    @ability.can :update_status, User::AdvisorStudent
    advisor_student = create(:user_advisor_student)
    new_status = :blacklisted
    get :update_status, id: advisor_student.id, status: new_status
    assert_response :redirect
    assert_equal advisor_student.reload.status.to_sym, new_status
  end
end
