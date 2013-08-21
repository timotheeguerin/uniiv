require 'test_helper'

class UserCourse::TakingControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get new_graph_embed" do
    get :new_graph_embed
    assert_response :success
  end

end
