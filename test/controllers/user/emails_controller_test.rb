require 'test_helper'

class User::EmailsControllerTest < ActionController::TestCase

  def setup
    bypass_rescue
  end

  test 'should not get create without permission' do
    assert_raise CanCan::AccessDenied do
      get :create
    end
  end

  test 'should get create' do
    @ability.can :edit, @user
    assert_difference '@user.emails.size' do
      get :create, email: 'random@email.com'
      assert_response :redirect
      @user.reload
    end

  end

  test 'should not set email as default without' do
    assert_raise CanCan::AccessDenied do
      user_email = create(:user_email)
      get :set_as_default, email: user_email.id
    end
  end

  test 'should set email as default' do
    @ability.can :edit, @user
    user_email = create(:user_email)
    get :set_as_default, email: user_email.id
    assert_response :redirect
    user_email.reload
    assert user_email.primary
  end

   test 'should not remove without permission' do
    assert_raise CanCan::AccessDenied do
      user_email = create(:user_email)
      get :remove, email: user_email.id
    end
  end
  test 'should remove email' do
    @ability.can :edit, @user
    assert_difference 'UserEmail.size', -1 do
      user_email = create(:user_email)
      get :remove, email: user_email.id
      assert_response :redirect
      @user.reload
    end
  end
end
