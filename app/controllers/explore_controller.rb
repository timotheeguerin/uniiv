class ExploreController < ApplicationController
  before_action :setup

  def setup
    authorize! :read, :explore
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
    get_courses
    @fullwidth = true
  end

  def courses_list
    puts 'SHJPUIDOAIDJOWAIEJDOAHWJOIJ'
    get_courses
    render :partial => 'course_list', :locals => {:results => @results}
  end

  def get_courses
    @results = {}
    @results[:subject] = Course::Subject.where(:id => params[:subject]).first
    params[:page] ||= 1
    if not @results[:subject].nil? or not (params[:q].nil? or params[:q].blank?)
      search_result= Course::Course.search do
        fulltext params[:q]
        with(:subject_id, params[:subject]) unless params[:subject].nil?
        paginate :page => params[:page], :per_page => 10
      end.results
      @results[:courses] = search_result
      @results[:next_page] = search_result.next_page unless search_result.last_page?
    end
    @results[:courses] ||= []
  end
  #List of all subjects
  def subjects
    @fullwidth = true
  end
end
