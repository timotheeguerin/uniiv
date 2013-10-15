require 'test_helper'

class Admin::Utils::CourseRequirementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
