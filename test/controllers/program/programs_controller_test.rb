require 'test_helper'

class Program::ProgramsControllerTest < ActionController::TestCase

  def program_params
    faculty = create(:faculty)
    type = create(:programs_type)
    {name: 'New program name', faculty_id: faculty.id, type_id: type.id}
  end

  test 'should not get new without permission' do
    assert_raise CanCan::AccessDenied do
      get :new
    end
  end

  test 'should get new' do
    @ability.can :create, Program::Program
    get :new
    assert_response :success
  end

  test 'should not create without permission' do
    params = program_params
    assert_raise CanCan::AccessDenied do
      get :create, program_program: params
    end
  end

  test 'should create new empty version' do
    @ability.can :create, Program::Program
    params = program_params
    assert_difference 'Program::Program.count' do
      get :create, program_program: params
      assert_response :redirect
    end
  end

  test 'should not get edit without permission' do
    program = create(:program_program)
    assert_raise CanCan::AccessDenied do
      get :edit, id: program.id
    end
  end


  test 'should get edit' do
    @ability.can :update, Program::Program
    program = create(:program_program)
    get :edit, id: program.id
    assert_response :success
  end

  test 'should not get update without permission' do
    program = create(:program_program)
    params = program_params
    assert_raise CanCan::AccessDenied do
      get :update, id: program.id, program_program: params
    end
  end

  test 'should update' do
    @ability.can :update, Program::Program
    program = create(:program_program)
    params = program_params
    get :update, id: program.id, program_program: params
    assert_response :redirect
    program.reload
    assert_equal program.name, params[:name]
    assert_equal program.type_id, params[:type_id]
    assert_equal program.faculty_id, params[:faculty_id]
  end

  test 'should not get show without permission' do
    program = create(:program_program)
    assert_raise CanCan::AccessDenied do
      get :show, id: program.id
    end
  end

  test 'should get show' do
    @ability.can :read, Program::Program
    program = create(:program_program)
    get :show, id: program.id
    assert_response :success
  end

  test 'should not destroy without permission' do
    program = create(:program_program)
    assert_raise CanCan::AccessDenied do
      get :destroy, id: program.id
    end
  end

  test 'should destroy' do
    @ability.can :destroy, Program::Program
    program = create(:program_program)
    assert_difference 'Program::Program.count', -1 do
      get :destroy, id: program.id
      assert_response :redirect
    end
  end
end
