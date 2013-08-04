class UserEmailController < ApplicationController

  def addemail
    uemail = new UserEmail()
    uemail.email = :email
    uemail.validated = false
    uemail.user = userarg
    uemail.university = uniarg
  end

end
