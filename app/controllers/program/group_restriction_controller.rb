#Controller to manage the group restriction(Min group, min credit)
class Program::GroupRestrictionController < ApplicationController
  def list
    group = Program::Group.find(params[:group])
    render :partial => 'list', :locals => {:group => group}
  end

  def create
    authorize! :create, Program::GroupRestriction
    restriction = Program::GroupRestriction.new
    restriction.group = Program::Group.find(params[:group])
    restriction.value = params[:value]
    restriction.type = Program::GroupRestrictionType.find(params[:type])
    if restriction.save
      return_json('Restriction added with success')
    else
      return_json(restriction.errors.full_messages, false)
    end
  end

  def delete
    authorize! :delete, Program::GroupRestriction
    restriction = Program::GroupRestriction.find(params[:restriction])
    if restriction.destroy
      return_json('Restriction deleted with success')
    else
      return_json(restriction.errors.full_messages, false)
    end
  end
end
