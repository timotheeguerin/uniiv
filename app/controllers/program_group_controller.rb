class ProgramGroupController < ApplicationController
  before_action :setup

  def setup
    @term = nil
    puts 'sme: ' + params[:semester].to_s
    unless params[:semester].nil? or params[:year].nil?
      year = params[:year]
      semester = Course::Semester.find(params[:semester])
      @term = Term.new(semester, year)
    end
    @term ||= Term::now

    @group = ProgramGroup.find(params[:id])

    @ratios = {}
    @ratios[:actual] = @group.get_completion_ratio(current_scenario)[:ratio] * 100 unless @term.nil?
    unless @term.nil?
      @ratios[:requested] = @group.get_completion_ratio(current_scenario, @term)[:ratio] * 100
      @ratios[:requested] = '' if @ratios[:actual] == @ratios[:requested]
    end
  end

  def show

  end

  def graph_embed
    render :layout => false
  end

end
