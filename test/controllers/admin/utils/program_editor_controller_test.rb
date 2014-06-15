#require 'test/unit'

require 'test_helper'

class Admin::Utils::ProgramEditorControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    @ability.can :edit, Program
    get :index
    assert_response :success
  end
end
