class Program::VersionController < ApplicationController

  before_action :setup

  def setup
  end

  def show
    authorize! :view, Program::Version
    @program_version = Program::Version.find(params[:id])
  end

  def change_version
    redirect_to program_version_path(:id => params[:version_id])
  end
  def new
    authorize! :new, Program::Version
    @program = Program::Program.find(params[:program_id])
    @program_version = Program::Version.new
  end

  def create
    authorize! :create, Program::Version
    @program = Program::Program.find(params[:program_id])
    template = Program::Version.find_by_id(params[:template])
    @program_version = if template.nil?
                         Program::Version.new
                       else
                         template.new_copy
                       end
    @program_version.assign_attributes(version_params)
    @program_version.program = @program
    if @program_version.save
      redirect_to program_path(@program)
    else
      render :new
    end
  end

  def edit
    @program_version = Program::Version.find(params[:id])
    authorize! :edit, @program_version
  end

  def update
    @program_version = Program::Version.find(params[:id])
    authorize! :update, @program_version
    @program_version.assign_attributes(version_params)
    if @program_version.save
      redirect_to program_path(@program_version.program)
    else
      render :edit
    end
  end


  def list
  end

  def delete
    @program_version = Program::Version.find(params[:id])
    authorize! :delete, @program_version
    @program_version.destroy
    redirect_or_json :destination => program_path(@program_version.program),
                     :success => true, :message => 'program.version.delete.success'
  end

  def version_params
    params.require(:program_version).permit(:start_year, :end_year)
  end
end
