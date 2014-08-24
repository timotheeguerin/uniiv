module User::InvitesHelper
  def user_invite_signup_link(invite)
    new_user_registration_url(invite_key: invite.key)
  end
end
