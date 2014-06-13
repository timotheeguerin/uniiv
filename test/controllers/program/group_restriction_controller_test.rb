require 'test_helper'

class Program::GroupRestrictionControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get list' do
    group = create(:program_group)
    get :list, :group => group.id
    assert_response :success
  end

  test 'should create restriction' do
    @ability.can :create, Program::GroupRestriction
    group = create(:program_group)
    type = create(:program_group_restriction_type)
    assert_difference('Program::GroupRestriction.count') do
      get :create, :group => group.id, :value => 5, :type => type
    end
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{JSON.parse(@response.body)}"
    group.destroy
  end

  test 'should delete restriction' do
    @ability.can :delete, Program::GroupRestriction
    group = create(:program_group)
    type = create(:program_group_restriction_type)
    restriction = Program::GroupRestriction.create!(:group => group, :type_id => type.id)
    assert_difference 'Program::GroupRestriction.count', -1 do
      get :delete, :restriction => restriction.id
    end
    assert JSON.parse(@response.body)['success'], "Json should return success but returned: #{JSON.parse(@response.body)}"
    group.destroy
  end


end
