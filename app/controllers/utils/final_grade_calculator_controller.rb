class Utils::FinalGradeCalculatorController < ApplicationController

  before_action :setup

  def setup
    authorize! :read, :fgc
    @prediction = Fgc::Prediction.find_by_user_id_and_course_id(current_user.id, params[:id])
    if @prediction.nil?
      @prediction = Fgc::Prediction.new
      @prediction.user = current_user
      @prediction.course = Course::Course.find(params[:id])
      @prediction.save
    end
  end

  def show
  end

  #Call when the user want to have a single grade(Midterm)
  def create_grade
    group = create
    group.simple = true
    group.save
    render :show
  end

  def edit_grade_value
    grade = Fgc::Grade.find(params[:grade])
    grade.value = params[:value]
    grade.save
    return_json('Value edited successfully')
  end

  def edit_grade_name
    grade = Fgc::Grade.find(params[:grade])
    grade.value = params[:name]
    grade.save
    return_json('Value edited successfully')
  end
  def delete_grade
    grade = Fgc::Grade.find(params[:grade])
    unless grade.nil?
      group = grade.group
      if group.grades.size == 1
        group.delete
      end
      grade.delete
    end
    return_json('Grade removed successfully')
  end

  #Called when the user create a new group for mulitple grade(All assignments)
  def create_group
    group = create
    group.simple = false
    group.save
    render :show
  end

  def add_grade_to_group
    group = Fgc::Group.find(params[:group])
    group.grades <<  Fgc::Grade.new
    group.save
    render :show
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
    percent = Pgc::Percent.find_by_group_id_and_scheme_id(params[:group], params[:scheme])
    percent.value = params[:percent]
    percent.save
    return_json('Group percent updated')
  end

  #Remove a group
  def delete_group
    group = Fgc::Group.find(params[:group])
    unless group.nil?
      group.delete
    end
    return_json('Group removed successfully')
  end

  #When the user created a new grading scheme(ex: midterm 0%)
  def new_scheme

  end
end
