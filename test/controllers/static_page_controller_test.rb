require 'test_helper'

class StaticPageControllerTest < ActionController::TestCase
  test "should get uniiv" do
    get :uniiv
    assert_response :success
  end

  test "should get story" do
    get :story
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

  test "should get getinvolved" do
    get :getinvolved
    assert_response :success
  end

  test "should get suggestions" do
    get :suggestions
    assert_response :success
  end

  test "should get bugreports" do
    get :bugreports
    assert_response :success
  end

  test "should get cookies" do
    get :cookies
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get termsofuse" do
    get :termsofuse
    assert_response :success
  end

end
