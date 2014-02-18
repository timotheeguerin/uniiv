class Utils::FinalGradeCalculatorController < ApplicationController

  before_action :setup

  def setup
    authorize! :read, :fgc
    @course = Course::Course.find(params[:id])
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
    grade.name = params[:name]
    grade.save
    return_json('Name edited successfully')
  end

  def delete_grade
    grade = Fgc::Grade.find(params[:grade])
    unless grade.nil?
      group = grade.group
      if group.grades.size == 1
        group.destroy
      end
      grade.destroy
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
    group.grades << Fgc::Grade.new
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

  def edit_final_percent
    @scheme = Fgc::Scheme.find(params[:scheme])
    @scheme.final_percent = params[:percent]
    @scheme.save
  end

  #When the user created a new grading scheme(ex: midterm 0%)
  def new_scheme

  end
end
