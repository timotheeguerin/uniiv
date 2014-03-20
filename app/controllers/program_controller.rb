class ProgramController < ApplicationController
  def show
    @program = Program::Program.find(params[:id])
  end

  def graph_embed
    @program = Program::Program.find(params[:id])
    render :layout => false
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
    authorize! :create, Program::Program
    @program = Program::Program.new
  end

  def create
    authorize! :create, Program::Program
    @program = Program::Program.new(program_params)

    if @program.save
      if params[:saveandedit]
        redirect_to program_edit_path(@program)
      else
        redirect_to admin_utils_program_editor_path
      end
    else
      render :new
    end
  end

  def edit
    @program = Program::Program.find(params[:id])
    authorize! :update, @program
  end

  def update
    @program = Program::Program.find(params[:id])
    authorize! :update, @program
    if @program.update(program_params)
      flash[:notice] = t('program.updated.success')
      if params[:saveandedit]
        redirect_to program_edit_path(@program)
      else
        redirect_to admin_utils_program_editor_path
      end
    else
      render :edit
    end
  end

  def delete
    @program = Program::Program.find(params[:id])
    authorize! :delete, @program
    @program.destroy
    redirect_to :back
  end

  def program_params
    params.require(:program).permit(:name, :type_id, :faculty_id)
  end

  def search
    s = Utils::Search.from_params(params)
    Program::Program.search_program(s)
    s
  end
end
