require 'test_helper'

class Issue::IssuesControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    @ability.can :create, Issue::Issue
    get :new
    assert_response :success
  end

  test 'should create issues' do
    @ability.can :create, Issue::Issue
    assert_difference 'Issue::Issue.count' do
      get :create, :issue => {:title => 'Some title', :content_attributes => {:text => 'Some text', :format => :markdown}}
      assert_response :redirect
    end
  end

  test 'should get show' do
    @ability.can :view, Issue::Issue
    issue = create(:issue_issue, :reporter => @user)
    get :show, :id => issue
    assert_response :success
  end

  test 'should get edit' do
    @ability.can :update, Issue::Issue
    issue = create(:issue_issue, :reporter => @user)
    get :edit, :id => issue.id
    assert_response :success
  end

  test 'should update issues' do
    @ability.can :update, Issue::Issue
    issue = create(:issue_issue, :reporter => @user)
    new_issue = {:title => 'Some new title', :content_attributes => {:text => 'Some new text', :format => :markdown}}
    get :update, :id => issue.id, :issue => new_issue
    assert_response :redirect
    issue.reload
    assert_equal new_issue[:title], issue.title
    assert_equal new_issue[:content_attributes][:text], issue.content.text
  end

  test 'should not be able to update issues without permission' do
    issue = create(:issue_issue, :reporter => @user)
    bypass_rescue
    new_issue = {:title => 'Some new title', :content_attributes => {:text => 'Some new text', :format => :markdown}}
    assert_raise CanCan::AccessDenied do
      get :destroy, id: issue.id, :issue => new_issue
    end
    issue.reload
    assert_not_equal new_issue[:title], issue.title
  end

  test 'should destroy issues' do
    @ability.can :destroy, Issue::Issue
    issue = create(:issue_issue, :reporter => @user)
    assert_difference 'Issue::Issue.count', -1 do
      get :destroy, id: issue.id
      assert_response :redirect
    end
  end

  test 'should not be able to destroy issues without permission' do
    issue = create(:issue_issue, :reporter => @user)
    bypass_rescue
    assert_no_difference 'Issue::Issue.count' do
      assert_raise CanCan::AccessDenied do
        get :destroy, id: issue.id
      end
    end
  end
end
