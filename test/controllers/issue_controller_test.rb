require 'test_helper'

class IssueControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    @ability.can :create, Issue::Issue
    get :new
    assert_response :success
  end

  test 'should create issue' do
    @ability.can :create, Issue::Issue
    assert_difference 'Issue::Issue.count' do
      get :create, :issue_issue => {:title => 'Some title', :content_attributes => {:text => 'Some text', :format => :markdown}}
      assert_response :redirect
    end
  end

  test 'should get show' do
    @ability.can :view, Issue::Issue
    issue = create(:issue_issue, :reporter => @user)
    get :show, :id => issue
    assert_response :success
  end

end
