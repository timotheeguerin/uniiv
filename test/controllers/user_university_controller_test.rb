require 'test_helper'

class UserUniversityControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get edit' do
    user = create(:user)
    sign_in user
    @ability.can :edit, user
    get :edit
    assert_response :success
    sign_out user
  end

  test 'should update university' do
    scenario = create(:course_scenario)
    user = scenario.user
    sign_in user
    @ability.can :edit, user

    program = create(:program_program)
    scenario.programs << program
    user.faculty = program.faculty
    user.save
    university = create(:university)
    get :update, :university_id => university.id
    assert_response :success
    user.reload
    assert user.university = university
    assert user.faculty.nil?
    assert user.main_course_scenario.programs.size == 0
    sign_out user
  end
end
