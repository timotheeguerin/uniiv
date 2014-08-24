class User::InvitesController < ApplicationController
  def index
    authorize! :view, User::Invite
    @invites = User::Invite.all
  end

  def new
    authorize! :create, User::Invite
    @invite = User::Invite.new
  end

  def create
    authorize! :create, User::Invite
    @invite = User::Invite.new(invite_params)

    if @invite.save
      flash[:notice] = t('invites.create.success')
      redirect_to user_invites_path
    else
      flash[:alert] = @invite.errors.full_messages
      render :new
    end
  end

  def destroy
    @invite = User::Invite.find(params[:id])
    authorize! :destroy, @invite
    @invite.destroy
    flash[:notice] = t('invites.destroy.success')
    redirect_to user_invites_path
  end

  private

  def invite_params
    params.require(:user_invite).permit(:message, :category, :amount)
  end
end
