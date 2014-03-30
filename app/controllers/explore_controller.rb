class ExploreController < ApplicationController
  before_action :setup

  def setup
    authorize! :view, :explore
  end

  def index

  end

  def programs
    results = Program::Program.search do
      fulltext params[:q]
    end.results
    @fullwidth = true

    @faculties = {}
    results.each do |program|
      @faculties[program.faculty] ||= {}
      @faculties[program.faculty][program.type] ||= []
      @faculties[program.faculty][program.type] << program
    end
    @faculties
  end

  def search

  end

  def get_results
    results = []
    if params[:program_only]
    elsif  params[:course_only]
    else
      results = Sunspot.search model_list do |query|
        query.fulltext params[:q]
      end
    end

  end
end
