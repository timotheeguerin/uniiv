require 'test_helper'

class Admin::Utils::CourseLoaderControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test 'should get new' do
    get :new
    assert_response :success
  end

end
