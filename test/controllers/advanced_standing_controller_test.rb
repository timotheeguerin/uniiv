require 'test_helper'

class AdvancedStandingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new_course" do
    get :add_course
    assert_response :success
  end

end
