class Program::ProgramsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = search
    @fullwidth = true
  end

  def show
    @program_version = @program.last_version
    if request.xhr?
      render layout: false
    end
  end

  def search_autocomplete
    programs = search.results
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    programs.each do |program|
      suggestion = {}
      suggestion[:value] = program.to_long_s
      suggestion[:data] = program.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end

  def new
  end

  def create

    if @program.save
      if params[:saveandedit]
        redirect_to edit_program_program_path(@program)
      else
        redirect_to program_programs_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @program.update(program_params)
      flash[:notice] = t('program.updated.success')
      if params[:saveandedit]
        redirect_to edit_program_program_path(@program)
      else
        redirect_to program_programs_path
      end
    else
      render :edit
    end
  end

  def destroy
    @program.destroy
    redirect_to :back
  end

  private

  def program_params
    params.require(:program_program).permit(:name, :type_id, :faculty_id)
  end

  def search
    ProgramSearcher.new(params).search
  end

  def reload_program
    @program = Program::Program.find(params[:id])
  end
end
