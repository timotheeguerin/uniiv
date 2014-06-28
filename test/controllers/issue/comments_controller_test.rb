require 'test_helper'

class Issue::CommentsControllerTest < ActionController::TestCase

  def setup
    bypass_rescue
  end

  test 'should get new' do
    @ability.can :comment, Issue::Issue
    issue = create(:issue_issue)
    get :new, issue_id: issue.id
    assert_response :success
  end

  test 'should get permission error when trying to create issue' do
    issue = create(:issue_issue)
    new_comment = {content: {text: 'My new comment', format: :markdown}}
    assert_no_difference 'issue.comments.size' do
      assert_raise CanCan::AccessDenied do
        get :create, issue_id: issue.id, comment: new_comment
        issue.reload
      end
    end
  end

  test 'should create comment' do
    @ability.can :comment, Issue::Issue
    issue = create(:issue_issue)
    new_comment = {content_attributes: {text: 'My new comment', format: :markdown}}
    assert_difference 'issue.comments.size' do
      get :create, issue_id: issue.id, comment: new_comment
      assert_response :redirect
      issue.reload
    end
  end

  test 'should get edit' do
    @ability.can :update, Issue::Comment
    comment = create(:issue_comment)
    issue = comment.issue
    get :edit, :issue_id => issue.id, id: comment.id
    assert_response :success
  end

  test 'should update comment' do
    @ability.can :update, Issue::Comment
    comment = create(:issue_comment)
    issue = comment.issue
    edited_comment = {content_attributes: {text: 'My edited comment', format: :markdown}}
    get :update, :issue_id => issue.id, id: comment.id, comment: edited_comment
    assert_response :redirect
    comment.reload
    assert_equal edited_comment[:content_attributes][:text], comment.content.text
  end

  test 'should not update comment without permission' do
    comment = create(:issue_comment)
    issue = comment.issue
    edited_comment = {content_attributes: {text: 'My edited comment', format: :markdown}}
    assert_raise CanCan::AccessDenied do
      get :update, :issue_id => issue.id, id: comment.id, comment: edited_comment
    end
    comment.reload
    assert_not_equal edited_comment[:content_attributes][:text], comment.content.text
  end

  test 'should destroy comment' do
    @ability.can :destroy, Issue::Comment
    comment = create(:issue_comment)
    assert_difference 'Issue::Comment.count', -1 do
      get :destroy, issue_id: comment.issue.id, id: comment.id
      assert_response :redirect
    end
  end

  test 'should not destroy comment without permission' do
    comment = create(:issue_comment)
    assert_no_difference 'Issue::Comment.count' do
      assert_raise CanCan::AccessDenied do
        get :destroy, issue_id: comment.issue.id, id: comment.id
        assert_response :redirect
      end
    end
  end
end
