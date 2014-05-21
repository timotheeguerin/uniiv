require 'test_helper'

class Program::VersionControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get new' do
    @ability.can :create, Program::ProgramVersion
    program = create(:program_program)

    get :new, :program_id => program.id
    assert_response :success
  end

  test 'should create new empty version' do
    @ability.can :create, Program::ProgramVersion
    program = create(:program_program)
    assert_difference 'program.versions.size' do
      get :create, :program_id => program.id, :program_program_version => {:start_year => 2014, :end_year => 2015}
      assert_response :redirect
      program.reload
    end
  end

  test 'should create new template version' do
    @ability.can :create, Program::ProgramVersion
    version = create(:program_program_version)
    program = version.program
    assert_difference 'program.versions.size' do
      get :create, :program_id => program.id,
          :program_program_version => {:start_year => 2014, :end_year => 2015},
          :template => version.id
      assert_response :redirect
      program.reload
    end
  end


  # test 'should get list' do
  #   get :list
  #   assert_response :success
  # end

end
