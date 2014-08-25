#Controller to manage the group restriction(Min group, min credit)
class Program::GroupRestrictionsController < ApplicationController
  load_and_authorize_resource

  def list
    group = Program::Group.find(params[:group])
    render partial: 'list', locals: {group: group}
  end

  def create
    @group_restriction.group = Program::Group.find(params[:group_id])
    @group_restriction.value = params[:value]
    @group_restriction.type = Program::GroupRestrictionType.find(params[:type])
    if @group_restriction.save
      return_json('Restriction added with success')
    else
      return_json(@group_restriction.errors.full_messages, false)
    end
  end

  def destroy
    if @group_restriction.destroy
      return_json('Restriction deleted with success')
    else
      return_json(@group_restriction.errors.full_messages, false)
    end
  end

  def reload_restriction
    @group_restriction = Program::GroupRestriction.find(params[:id])
  end
end
