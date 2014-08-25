#Controller to manage the group restriction(Min group, min credit)
class Program::Group::RestrictionsController < ApplicationController
  load_and_authorize_resource :group, class: 'Program::Group'
  load_and_authorize_resource :through => :group, class: 'Program::Group::Restriction', except: :list

  def list
    authorize! :read, Program::Group::Restriction
    render partial: 'list', locals: {group: @group}
  end

  def create
    @restriction.group = @group
    if @restriction.save
      return_json('Restriction added with success')
    else
      return_json(@restriction.errors.full_messages, success: false)
    end
  end

  def destroy
    if @restriction.destroy
      return_json('Restriction deleted with success')
    else
      return_json(@restriction.errors.full_messages, success: false)
    end
  end

  def restriction_params
    params.require(:restriction).permit(:value, :type_id)
  end
  def reload_restriction
    @restriction = Program::Group::Restriction.find(params[:id])
    @group = Program::Group.find(params[:group_id])
  end
end
