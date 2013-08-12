class UserEmailsController < ApplicationController

  def index
  end
  
  def addEmail
  em = params["email"]
  current_user.emails.each do |e|
    if e.email == em
      flash[:alert] = t("useremail.duplicate")
    redirect_to user_emails_index_path
    return
    end
  end
  
    email = UserEmail.new
    email.user = current_user
    email.email = em
    email.save
    
    flash[:notice] = t("useremail.add")
    redirect_to user_emails_index_path
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
    flash[:notice] = t("useremail.makedefault")
    redirect_to user_emails_index_path
  end
  
    def removeEmail
    emailid = params["data-service"]
    email = UserEmail.find(emailid)
    email.destroy
    flash[:notice] = t("useremail.remove")
    redirect_to user_emails_index_path
  end

end
