class ProgramGroupController < ApplicationController

  def setup
    @term = nil
    unless params[:semester].nil? or params[:year].nil?
      year = params[:year]
      semester = Course::Semester.find(params[:semester])
      @term = Utils::Term.new(semester, year)
    end
    @term ||= Utils::Term::now

    @group = Program::Group.find(params[:id])

    @ratios = {}
    @ratios[:actual] = @group.get_completion_ratio(current_scenario).percent.to_i
    unless @term.nil?
      @ratios[:requested] = @group.get_completion_ratio(current_scenario, @term).percent.to_i
      @ratios[:requested] = '' if @ratios[:actual] == @ratios[:requested]
    end
  end

  def show
    setup
  end

  def new
    @program_group = Program::Group.new
    @program_group.groupparent = find_parent
  end

  def create
    @program_group = Program::Group.new(program_group_params)
    @program_group.groupparent = find_parent
    if @program_group.save
      if params[:saveandedit]
        redirect_to program_group_edit_path(@program_group)
      else
        redirect_to_parent
      end
    else
      render :new
    end
  end

  def edit
    @program_group= Program::Group.find(params[:id])
  end

  def update
    @program_group= Program::Group.find(params[:id])
    if @program_group.update(program_group_params)
      if params[:saveandedit]
        redirect_to program_group_edit_path(@program_group)
      else
        redirect_to_parent
      end
    else
      render :edit
    end
  end

  def delete
    @program_group = Program::Group.find(params[:id])
    authorize! :delete, @program_group
    @program_group.destroy
    redirect_to :back
  end

  def program_group_params
    params.require(:program_group).permit(:name, :restriction_id, :value)
  end

  def find_parent
    params[:parent_type].constantize.find(params[:parent_id])
  end

  def graph_embed
    setup
    render :layout => false
  end

  def redirect_to_parent
    if @program_group.groupparent.is_a? Program::Version
      redirect_to program_edit_path(@program_group.groupparent)
    elsif @program_group.groupparent.is_a? Program::Group
      redirect_to program_group_edit_path(@program_group.groupparent)
    end
  end

end
