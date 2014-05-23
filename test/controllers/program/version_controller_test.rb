require 'test_helper'

class Program::VersionControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should not get new' do
    program = create(:program_program)
    get :new, :program_id => program.id
    assert_response :redirect
  end

  test 'should get new' do
    @ability.can :new, Program::Version
    program = create(:program_program)

    get :new, :program_id => program.id
    assert_response :success
  end

  test 'should create new empty version' do
    @ability.can :create, Program::Version
    program = create(:program_program)
    assert_difference 'program.versions.size' do
      get :create, :program_id => program.id, :program_version => {:start_year => 2014, :end_year => 2015}
      assert_response :redirect
      program.reload
    end
  end

  test 'should create new template version' do
    @ability.can :create, Program::Version
    version = create(:program_version)
    program = version.program
    assert_difference 'program.versions.size' do
      get :create, :program_id => program.id,
          :program_version => {:start_year => 2014, :end_year => 2015},
          :template => version.id
      assert_response :redirect
      program.reload
    end
  end

  test 'should get edit' do
    @ability.can :edit, Program::Version
    version = create(:program_version)
    get :edit, :id => version.id
    assert_response :success
  end

  test 'should update' do
    @ability.can :edit, Program::Version
    version = create(:program_version)
    get :update, :id => version.id, :program_version => {:start_year => 2014, :end_year => 2015}
    assert_response :redirect
    version.reload
    assert version.start_year = 2014
    assert version.end_year = 2015
  end

  test 'should get show' do
    @ability.can :view, Program::Version
    version = create(:program_version)
    program = version.program
    get :show, :id => version.id
    assert_response :success
  end
end
