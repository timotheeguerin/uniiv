class User::AdvisorStudentsController < ApplicationController

  def index
    authorize! :view, User::AdvisorStudent
    if current_user.student?
      @advisors = current_user.advisor_students
      render :index_student
    elsif current_user.advisor?
      @filter = get_filter
      @students = current_user.advisor_students.where(status: User::AdvisorStudent.statuses[@filter])
      render :index_advisor
    end
  end

  def new
    @advisor_student = User::AdvisorStudent.new
  end

  def create
    @advisor_student = User::AdvisorStudent.new(advisor_student_params)
    @advisor_student.status = :validated if current_user.advisor?
    if @advisor_student.save
      redirect_to user_advisor_students_path
    else
      flash[:alert] = @advisor_student.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @advisor_student = User::AdvisorStudent.find(params[:id])
    authorize! :destroy, @advisor_student
    current_user.destroy_advisor_student(@advisor_student)
    redirect_to user_advisor_students_path
  end

  def validate
    @advisor_student = User::AdvisorStudent.find(params[:id])
    authorize! :validate, @advisor_student
    @advisor_student.validated = true
    @advisor_student.save
    redirect_to user_advisor_students_path
  end

  def update_status
    new_status = params[:status]
    @advisor_student = User::AdvisorStudent.find(params[:id])
    authorize! :update_status, @advisor_student
    @advisor_student.status = new_status
    @advisor_student.save
    redirect_to user_advisor_students_path
  end

  def advisor_student_params
    params.require(:user_advisor_student).permit(:advisor_id, :student_id)
  end


  def get_filter
    if params[:filter]
      params[:filter].to_sym
    else
      :requested
    end
  end
end
