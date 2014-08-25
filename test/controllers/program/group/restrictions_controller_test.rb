require 'test_helper'

class Program::Group::RestrictionsControllerTest < ActionController::TestCase

  def restriction_params
    type = create(:program_group_restriction_type)
    {value: 3, type_id: type.id}
  end

  test 'should get list' do
    @ability.can :read, Program::Group
    @ability.can :read, Program::Group::Restriction
    group = create(:program_group)
    get :list, group_id: group.id
    assert_response :success
  end

  test 'should create restriction' do
    @ability.can :read, Program::Group
    @ability.can :create, Program::Group::Restriction
    group = create(:program_group)
    params = restriction_params
    assert_difference('Program::Group::Restriction.count') do
      get :create, group_id: group.id, restriction: params
    end
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{JSON.parse(@response.body)}"
    group.destroy
  end

  test 'should delete restriction' do
    @ability.can :read, Program::Group
    @ability.can :destroy, Program::Group::Restriction
    restriction = create(:program_group_restriction)
    assert_difference 'Program::Group::Restriction.count', -1 do
      get :destroy, group_id: restriction.group.id, id: restriction.id
    end
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{JSON.parse(@response.body)}"
  end
end
