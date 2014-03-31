class ExploreController < ApplicationController
  before_action :setup

  def setup
    authorize! :view, :explore
  end

  def index
    @fullwidth = true
    @showcase = {}
    if current_user.faculty.nil?
      @showcase[:faculty] = Faculty.offset(rand(Faculty.count)).first
    else
      @showcase[:faculty] = current_user.faculty
    end

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



  def courses
    @subject = Course::Subject.where(:id => params[:subject]).first
    results = Course::Course.search do
      fulltext params[:q]
      with(:subject_id, @subject.id) unless @subject.nil?
    end.results
    @fullwidth = true
    @courses = results
  end

  #List of all subjects
  def subjects
    @fullwidth = true
  end
end
