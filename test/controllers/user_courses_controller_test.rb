require 'test_helper'

class UserCoursesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
