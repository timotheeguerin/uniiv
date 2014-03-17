class Admin::Utils::CourseRequirementsController < ApplicationController

  before_action :setup

  def setup
    authorize! :manage, :admin_utils
  end

  def index
    @uncompleted_courses = Admin::CourseRequirementFilled.where { (prerequisites == false) | (corequisites == false) }.limit(10)
  end

  def mark_as_none
    course = Admin::CourseRequirementFilled.find(params[:id])
    if params[:type] == 'corequisites'
      course.corequisites = true
    else
      course.prerequisites = true
    end
    course.save
    redirect_to admin_utils_check_course_requirements_completed_path
  end

  def input_requirement
    @course = Admin::CourseRequirementFilled.find(params[:id])
    @type = params[:type]
    @subject_requirements = []

    @expr = nil
    if params[:type]== 'corequisites'
      unless @course.course.corequisite.nil?
        @expr = @course.course.corequisite.to_input
        @subject_requirements = @course.course.corequisite.node.subject_requirement_nodes
      end
      @read = @course.corequisite_read
    else
      unless @course.course.prerequisite.nil?
        @expr = @course.course.prerequisite.to_input
        @subject_requirements = @course.course.prerequisite.node.subject_requirement_nodes
      end
      @read = @course.prerequisite_read
    end
  end

  def subject_input_requirement
    requirement = Course::SubjectRequirementNode.new
    render :partial => 'subject_requirement_input', :locals => {:requirements => [requirement]}
  end

  def save_requirement
    @course = Admin::CourseRequirementFilled.find(params[:id])

    input = params[:expr]

    @subject_requirements = get_subject_requirement_params(params)
    puts @subject_requirements
    @expr = Course::Expr.parse(input, @subject_requirements)

    if @expr.nil?
      flash[:alert] = "Error parsing the expression '#{input}', one of the course entered might not exist!"
      render :input_requirement
    else
      @expr.save

      if params[:type]== 'corequisites'
        @course.corequisites = true
        @course.course.corequisite = @expr
      else
        @course.prerequisites = true
        @course.course.prerequisite = @expr
      end
      @course.course.save
      @course.save
      flash[:notice] = "Expression parsed #{@expr.node}!"
      redirect_to admin_utils_check_course_requirements_completed_path
    end
  end


  def get_subject_requirement_params(params)
    results = []
    params.each do |key, value|
      if key.match /^subject_requirement_[0-9]+$/
        requirement = Course::SubjectRequirementNode.new
        requirement.amount = value[:amount]
        requirement.subject = Course::Subject.find_by_name(value[:subject])
        requirement.level = value[:level]
        results << requirement
      end
    end
    results
  end
end
