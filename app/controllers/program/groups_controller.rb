class Program::GroupsController < ApplicationController
  load_and_authorize_resource

  def show
    render layout: false if request.xhr?
  end

  def new
    @group.parent = find_parent
  end

  def create
    @group.parent = find_parent
    if @group.save
      if params[:saveandedit]
        redirect_to edit_program_group_path(@group)
      else
        redirect_to_parent
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.assign_attributes(group_params)
    if @group.save
      if params[:saveandedit]
        redirect_to edit_program_group_path(@group)
      else
        redirect_to_parent
      end
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to :back
  end

  private
  def find_parent
    if params.key?(:parent_type) and params.key?(:parent_id)
      params[:parent_type].constantize.find(params[:parent_id])
    else
      fail ActiveRecord::RecordNotFound
    end
  end

  def redirect_to_parent
    if @group.parent.is_a? Program::Version
      redirect_to edit_program_program_path(@group.parent)
    elsif @group.parent.is_a? Program::Group
      redirect_to edit_program_group_path(@group.parent)
    end
  end


  def group_params
    params.require(:program_group).permit(:name)
  end

  def reload_group
    @group = Program::Group.find(params[:id])
  end
end