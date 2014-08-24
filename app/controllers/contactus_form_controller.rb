class ContactusFormController < ApplicationController
  def new
    @fullwidth = true
  end

  def create
    @form = ContactusForm.new(contactus_form_params)

    if @form.save
      redirect_to root_path, :notice => t('contactus.success')
    else
      @fullwidth = true
      render :new, :alert => @form.errors.full_messages
    end
  end

  def contactus_form_params
    params.require(:contactus_form).permit(:email, :content)
  end
end
