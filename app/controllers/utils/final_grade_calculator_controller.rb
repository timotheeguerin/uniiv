class Utils::FinalGradeCalculatorController < ApplicationController

  before_action :setup, :except => [:index, :search]

  def setup
    authorize! :read, :fgc
    @course = Course::Course.find(params[:id])
    @prediction = Fgc::Prediction.find_by_user_id_and_course_id(current_user.id, params[:id])
    if @prediction.nil?
      @prediction = Fgc::Prediction.new
      @prediction.user = current_user
      @prediction.course = Course::Course.find(params[:id])
      scheme = Fgc::Scheme.new
      @prediction.schemes << scheme
      @prediction.save

    end
  end

  def index
    authorize! :read, :fgc
    @courses =[]
    if params[:q]
      @courses = Course::Course.search do
        fulltext params[:q]
        paginate :page => 1, :per_page => 10
      end.results
    end
  end

  def search
    authorize! :read, :fgc
    courses = Course::Course.search do
      fulltext params[:q]
      paginate :page => 1, :per_page => 10
    end.results
    render :partial => 'course_link_list', :layout => false, :locals => {:courses => courses}
  end

  def show
    @fullwidth = true
  end

  #Call when the user want to have a single grade(Midterm)
  def create_grade
    group = create
    unless group.save
      flash[:alert] = group.errors.full_messages
    end
    _redirect_to utils_fgc_course_path(@prediction.course_id)
  end

  def edit_grade_value
    grade = Fgc::Grade.find(params[:grade])
    grade.value = params[:value]
    grade.save
    return_json('Value edited successfully')
  end

  def edit_grade_name
    grade = Fgc::Grade.find(params[:grade])
    grade.name = params[:name]
    grade.save
    return_json('Name edited successfully')
  end

  def remove_grade
    grade = Fgc::Grade.find(params[:grade])
    unless grade.nil?
      group = grade.group
      if group.grades.size == 1
        group.destroy
      end
      grade.destroy
    end
    _redirect_to utils_fgc_course_path(@prediction.course_id)
  end

  def create_scheme
    scheme = Fgc::Scheme.new
    @prediction.schemes << scheme
    @prediction.groups.each do |group|
      percent = Fgc::Percent.new
      percent.group = group
      percent.value = 0
      scheme.percents << percent
    end
    @prediction.save
    _redirect_to utils_fgc_course_path(@prediction.course_id)
  end

  def remove_scheme
    scheme = Fgc::Scheme.find(params[:scheme])
    scheme.destroy
    _redirect_to utils_fgc_course_path(@prediction.course_id)
  end

  def add_grade_to_group
    group = Fgc::Group.find(params[:group])
    grade = Fgc::Grade.new
    last_name = group.grades.last.name
    last_name ||= ''

    match = last_name.scan(/(\d+)/)[0]
    if match.nil? or match.size == 0
      grade.name = "#{last_name} 2"
    else
      count = match[-1].to_i
      count ||= 0
      grade.name = last_name.gsub(/(\d+)/, (count+1).to_s)
    end


    group.grades << grade
    group.save
    _redirect_to utils_fgc_course_path(@prediction.course_id)
  end

  def remove_group
    group = Fgc::Group.find(params[:group])
    group.destroy
    _redirect_to utils_fgc_course_path(@prediction.course_id)
  end

  def create
    grade = Fgc::Grade.new
    group = Fgc::Group.new
    if @prediction.schemes.empty?
      @prediction.schemes << Fgc::Scheme.new
    end
    @prediction.schemes.each do |scheme|
      percent = Fgc::Percent.new
      percent.scheme = scheme
      percent.value = 0
      group.percents << percent
    end
    group.grades << grade
    @prediction.groups << group
    @prediction.save
    group
  end

  #Edit the percent value of the group
  def edit_group_percent
    percent = Fgc::Percent.find(params[:percent])
    percent.value = params[:value]
    percent.save
    return_json('Group percent updated')
  end

  #Remove a group
  def delete_group
    group = Fgc::Group.find(params[:group])
    unless group.nil?
      group.destroy
    end
    return_json('Group removed successfully')
  end

  #When the user created a new grading scheme(ex: midterm 0%)
  def new_scheme

  end
end
