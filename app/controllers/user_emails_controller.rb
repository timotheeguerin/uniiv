class UserEmailsController < ApplicationController

  def index
  end

  def makeDefault
    emailid = params["data-service"]
    email = UserEmail.find(emailid)
    user = email.user
    user.email = email.email
    user.emails.each do |e|
      e.primary = false
      e.save
    end
    email.primary = true
    email.save
    user.save
    redirect_to user_emails_index_path
  end
  
    def removeEmail
    emailid = params["data-service"]
    email = UserEmail.find(emailid)
    email.destroy
    redirect_to user_emails_index_path
  end

end
