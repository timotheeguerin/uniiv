class ProgramController < ApplicationController
  def show
    @program = Program.find(params[:id])
  end

  def graph_embed
    @program = Program.find(params[:id])
    render :layout => false
  end

  def search_autocomplete
    programs = search
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
    authorize! :create, Program
    @program = Program.new
  end

  def create
    authorize! :create, Program
    @program = Program.new(program_params)

    if @program.save
      redirect_to admin_utils_program_path
    end
    redirect_to admin_utils_program_path
  end

  def edit
    @program = Program.find(params[:id])
    authorize! :update, @program
  end

  def update
    @program = Program.find(params[:id])
    authorize! :update, @program
    if @program.update(program_params)
      flash[:notice] = t('program.updated.success')
      if params[:saveandedit]
        redirect_to admin_utils_program_edit_path(@program)
      else
        redirect_to admin_utils_program_path
      end
    else
      render :edit
    end
  end

  def delete
    @program = Program.find(params[:id])
    authorize! :delete, @program
    @program.destroy
    redirect_to :back
  end

  def program_params
    params.require(:program).permit(:name, :type_id, :faculty_id)
  end
  def search
    s = Search.from_params(params)
    Program.search_program(s)
    s
  end
end
