class User::InvitesController < ApplicationController
  def index
    @invites = User::Invite.all
  end

  def new
    @invite = User::Invite.new
  end

  def create

  end

  private

  def invite_params
  end
end
