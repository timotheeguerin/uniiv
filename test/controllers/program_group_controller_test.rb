require 'test_helper'

class ProgramGroupControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get graph_embed" do
    get :graph_embed
    assert_response :success
  end

end
