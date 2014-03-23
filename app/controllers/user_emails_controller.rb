class UserEmailsController < ApplicationController

  def index
    authorize! :edit, current_user
  end

  def addEmail
    authorize! :edit, current_user
    em = params["email"]
    UserEmail.all.each do |e|
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
    authorize! :edit, current_user
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
    authorize! :edit, current_user
    emailid = params["data-service"]
    email = UserEmail.find(emailid)
    email.destroy
    flash[:notice] = t("useremail.remove")
    redirect_to user_emails_index_path
  end

end
