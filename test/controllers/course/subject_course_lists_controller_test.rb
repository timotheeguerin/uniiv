require 'test_helper'

class Course::SubjectCourseListsControllerTest < ActionController::TestCase

  test 'should not get show without permission' do
    subject_course_list = create(:course_subject_course_list)
    assert_raise CanCan::AccessDenied do
      get :show, id: subject_course_list.id
    end
  end

  test 'should show' do
    @ability.can :read, Course::SubjectCourseList
    subject_course_list = create(:course_subject_course_list)
    get :show, id: subject_course_list.id
    assert_response :success
  end

  test 'should not get new without permission' do
    group = create(:program_group)
    assert_raise CanCan::AccessDenied do
      get :new, group_id: group.id
    end
  end

  test 'should get new' do
    @ability.can :create, Course::SubjectCourseList
    group = create(:program_group)
    get :new, group_id: group.id
    assert_response :success
  end

  test 'should not create without permission' do
    group = create(:program_group)
    subject = create(:course_subject)
    subject_course_list_params = {subject: subject.name, level: 300, operation: 'LESS', group_id: group.id}
    assert_raise CanCan::AccessDenied do
      get :create, subject_course_list: subject_course_list_params
    end
  end
  test 'should  create' do
    @ability.can :create, Course::SubjectCourseList
    group = create(:program_group)
    subject = create(:course_subject)
    subject_course_list_params = {subject: subject.name, level: 300, operation: 'LESS', group_id: group.id}
    assert_difference 'Course::SubjectCourseList.count' do
      get :create, subject_course_list: subject_course_list_params
      assert_response :redirect
    end
  end

  test 'should not get edit without permission' do
    subject_course_list = create(:course_subject_course_list)

    assert_raise CanCan::AccessDenied do
      get :edit, id: subject_course_list.id
    end
  end

  test 'should get edit' do
    @ability.can :update, Course::SubjectCourseList
    subject_course_list = create(:course_subject_course_list)

    get :edit, id: subject_course_list
    assert_response :success
  end


  test 'should not update without permission' do
    group = create(:program_group)
    subject = create(:course_subject)
    subject_course_list = create(:course_subject_course_list)

    subject_course_list_params = {subject: subject.name, level: 300, operation: 'LESS', group_id: group.id}
    assert_raise CanCan::AccessDenied do
      get :update, id: subject_course_list.id, subject_course_list: subject_course_list_params
    end
  end

  test 'should  update' do
    @ability.can :update, Course::SubjectCourseList
    group = create(:program_group)
    subject = create(:course_subject)
    subject_course_list = create(:course_subject_course_list)
    subject_course_list_params = {subject: subject.name, level: 300, operation: 'LESS', group_id: group.id}
    get :update, id: subject_course_list.id, subject_course_list: subject_course_list_params
    assert_response :redirect
    subject_course_list.reload
    assert_equal subject_course_list.level, subject_course_list_params[:level]
  end

  test 'should not destroy without permission' do
    subject_course_list = create(:course_subject_course_list)
    assert_raise CanCan::AccessDenied do
      get :destroy, id: subject_course_list.id
    end
  end

  test 'should destroy issues' do
    @ability.can :destroy, Course::SubjectCourseList
    subject_course_list = create(:course_subject_course_list)

    assert_difference 'Course::SubjectCourseList.count', -1 do
      get :destroy, id: subject_course_list.id
      assert_response :redirect
    end
  end
end