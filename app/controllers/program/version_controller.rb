class Program::VersionController < ApplicationController

  before_action :setup

  def setup
    @program = Program::Program.find(params[:program_id])
  end

  def new
    authorize! :new, Program::ProgramVersion
    @program_version = Program::ProgramVersion.new
  end

  def create
    authorize! :new, Program::ProgramVersion
    template = Program::ProgramVersion.find_by_id(params[:template])
    @program_version = if template.nil?
                         Program::ProgramVersion.new
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

  def list
  end

  def version_params
    params.require(:program_program_version).permit(:start_year, :end_year)
  end
end
