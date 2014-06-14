require 'test_helper'
class Program::GroupControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should show group' do
    @ability.can :view, Program::Group
    group = create(:program_group)
    get :show, :id => group.id
    assert_response :success
  end

  test 'should return 404 without group' do
    assert_raises ActiveRecord::RecordNotFound do
      get :show, :id => 0
    end
  end

  test 'should get new page' do
    @ability.can :create, Program::Group
    version = create(:program_version)
    get :new, :parent_type => version.class.to_s, :parent_id => version.id
    assert_response :success
  end

  test 'should return active record not found if parent not given' do
    @ability.can :create, Program::Group
    assert_raises ActiveRecord::RecordNotFound do
      get :new, :id => 0
    end
  end

  test 'should create program group' do
    @ability.can :create, Program::Group
    version = create(:program_version)
    assert_difference 'version.groups.count' do
      get :create, :group => {:name => 'Some random name'}, :parent_type => version.class.to_s, :parent_id => version.id
    end
    assert_response :redirect
  end

  test 'should not create group when params missing' do
    @ability.can :create, Program::Group
    version = create(:program_version)
    assert_no_difference 'version.groups.count' do
      get :create, :group => {:name => nil}, :parent_type => version.class.to_s, :parent_id => version.id
    end
    assert_response :success
  end

  test 'should get edit' do
    @ability.can :update, Program::Group
    group = create(:program_group)
    get :edit, :id => group.id
    assert_response :success
  end

  test 'edit return active record not found if parent not given' do
    @ability.can :update, Program::Group
    assert_raises ActiveRecord::RecordNotFound do
      get :edit, :id => 0
    end
  end

  test 'should update group' do
    @ability.can :update, Program::Group
    group = create(:program_group)
    new_name = 'New name'
    get :update, :id => group.id, :group => {:name => new_name}
    assert_response :redirect
    group.reload
    assert_equal new_name, group.name
  end

  test 'should not update group if missing params' do
    @ability.can :update, Program::Group
    group = create(:program_group)
    old_name = group.name
    get :update, :id => group.id, :group => {:name => nil}
    assert_response :success
    group.reload
    assert_equal old_name, group.name
  end

  test 'should delete group' do
    @ability.can :delete, Program::Group
    group = create(:program_group)
    assert_difference 'Program::Group.count', -1 do
      get :delete, :id => group.id
      assert_response :redirect
    end
  end
end