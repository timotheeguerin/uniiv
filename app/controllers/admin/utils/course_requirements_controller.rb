class Admin::Utils::CourseRequirementsController < ApplicationController

  before_action :setup

  def setup
    authorize! :manage, :admin_utils
  end

  def index
    @uncompleted_courses = Admin::CourseRequirementFilled.where { (prerequisites == false) | (corequisites == false) }
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
    @type = params[:type]
  end

  def save_requirement
    course = Admin::CourseRequirementFilled.find(params[:id])

    input = params['expr']
    expr = Course::Expr.parse(input)
    if expr.nil?
      flash[:error] = "Error parsing the expression '#{input}', one of the course entered might not exist!"
      render :input_requirement
    else
      expr.save


      if params[:type]== 'corequisites'
        course.corequisites = true
        course.course.corequisite =expr
      else
        course.prerequisites = true
        course.course.prerequisite =expr
      end
      course.course.save
      course.save
      redirect_to admin_utils_check_course_requirements_completed_path
    end
  end
end
