require 'test_helper'

class Issue::IssuesControllerTest < ActionController::TestCase

  test 'should not get index without permission' do
    assert_raise CanCan::AccessDenied do
      get :index
    end
  end

  test 'should get index' do
    @ability.can :index, Issue::Issue
    get :index
    assert_response :success
  end

  test 'should not get new without permission' do
    assert_raise CanCan::AccessDenied do
      get :new
    end
  end

  test 'should redirect if user does not have an advisor' do
    @ability.can :create, Issue::Issue
    get :new
    assert_response :redirect
  end

  test 'should get new if user has an advisor' do
    create(:user_advisor_student, student: @user)
    @ability.can :create, Issue::Issue
    get :new
    assert_response :success
  end

  test 'should not create without permission' do
    assert_raise CanCan::AccessDenied do
      get :create, issue: {title: 'Some title', content_attributes: {text: 'Some text', format: :markdown}}
    end
  end
  test 'should create issues' do
    @ability.can :create, Issue::Issue
    assert_difference 'Issue::Issue.count' do
      get :create, issue: {title: 'Some title', content_attributes: {text: 'Some text', format: :markdown}}
      assert_response :redirect
    end
  end


  test 'should not get show without permission' do
    issue = create(:issue_issue, :reporter => @user)
    assert_raise CanCan::AccessDenied do
      get :show, id: issue.id
    end
  end

  test 'should get show' do
    @ability.can :show, Issue::Issue
    issue = create(:issue_issue, :reporter => @user)
    get :show, :id => issue
    assert_response :success
  end

  test 'should not get edit without permission' do
    issue = create(:issue_issue, :reporter => @user)
    assert_raise CanCan::AccessDenied do
      get :edit, id: issue.id
    end
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

    new_issue = {:title => 'Some new title', :content_attributes => {:text => 'Some new text', :format => :markdown}}
    assert_raise CanCan::AccessDenied do
      get :destroy, id: issue.id, :issue => new_issue
    end
    issue.reload
    assert_not_equal new_issue[:title], issue.title
  end

  test 'should not destroy without permission' do
    issue = create(:issue_issue, :reporter => @user)
    assert_raise CanCan::AccessDenied do
      get :destroy, id: issue.id
    end
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
    assert_no_difference 'Issue::Issue.count' do
      assert_raise CanCan::AccessDenied do
        get :destroy, id: issue.id
      end
    end
  end

  test 'should change issue status' do
    @ability.can :change_status, Issue::Issue
    issue = create(:issue_issue, status: :open)
    new_status = :close
    get :change_status, id: issue.id, status: new_status
    assert_response :redirect
    issue.reload
    assert_equal new_status.to_s, issue.status
  end
end
