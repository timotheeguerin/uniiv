require 'test_helper'

class User::CoursePlannerControllerTest < ActionController::TestCase
  def setup
    bypass_rescue
  end

  test 'should not get index without permission' do
    assert_raise CanCan::AccessDenied do
      get :index
    end
  end

  test 'should get index' do
    @ability.can :edit, @user
    get :index
    assert_response :success
  end

  test 'should not get take_course without permission' do
    assert_raise CanCan::AccessDenied do
      course = create(:course_course)
      get :take_course, id: course.id
    end
  end

  test 'should take course' do
    @ability.can :edit, @user
    semester = create(:course_semester)
    year = 2014
    course = create(:course_course)
    assert_difference 'UserTakingCourse.count' do
      get :take_course, id: course.id, semester_id: semester.id, year: year
      assert_response :success
    end
  end

  test 'should not get untake_course without permission' do
    assert_raise CanCan::AccessDenied do
      course = create(:course_course)
      get :untake_course, id: course.id
    end
  end

  test 'should untake course' do
    @ability.can :edit, @user
    taking_course = create(:user_taking_course, course_scenario: @user.main_course_scenario)

    assert_difference 'UserTakingCourse.count', -1 do
      get :untake_course, id: taking_course.course.id
      assert_response :success
    end
  end
end
