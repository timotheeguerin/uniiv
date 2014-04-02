class ContactusFormController < ApplicationController
  def new
    @fullwidth = true
  end
  def create
    @form = ContactusForm.new(params.require(:contactus_form).permit(:email, :content))

    if @form.save
      redirect_to root_path, :notice => t('contactus.success')
    else
      @fullwidth = true
      render :new, :alert => @form.errors.full_messages
    end
  end
end
