require 'test_helper'

class User::InvitesControllerTest < ActionController::TestCase

  test 'should not get index without permission' do
    assert_raise CanCan::AccessDenied do
      get :index
    end
  end

  test 'should get index' do
    @ability.can :view, User::Invite
    get :index
    assert_response :success
  end

  test 'should not get new without permission' do
    assert_raise CanCan::AccessDenied do
      get :new
    end
  end

  test 'should get new' do
    @ability.can :create, User::Invite
    get :new
    assert_response :success
  end

  test 'should not get create without permission' do
    assert_raise CanCan::AccessDenied do
      get :create
    end
  end

  test 'should get create' do
    @ability.can :create, User::Invite
    invite_params = {message: 'Invite message', category: 'User::Advisor', amount: 1}
    assert_difference 'User::Invite.count' do
      get :create, user_invite: invite_params
      assert_response :redirect
    end
  end

  test 'should not destroy without permission' do
    invite = create(:user_invite)
    assert_raise CanCan::AccessDenied do
      get :destroy, id: invite.id
    end
  end

  test 'should destroy invite' do
    @ability.can :destroy, User::Invite
    invite = create(:user_invite)
    assert_difference 'User::Invite.count', -1 do
      get :destroy, id: invite.id
    end
  end
end
