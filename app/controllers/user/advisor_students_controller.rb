class User::AdvisorStudentsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.student?
      render :index_student
    elsif current_user.advisor?
      @filter = filter
      @advisor_students = @advisor_students.where(status: User::AdvisorStudent.statuses[@filter])
      render :index_advisor
    end
  end

  def new
    @advisor_student = User::AdvisorStudent.new
  end

  def create
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
    current_user.destroy_advisor_student(@advisor_student)
    redirect_to user_advisor_students_path
  end

  def validate
    @advisor_student.validated = true
    @advisor_student.save
    redirect_to user_advisor_students_path
  end

  def update_status
    new_status = params[:status]
    @advisor_student.status = new_status
    @advisor_student.save
    redirect_to user_advisor_students_path
  end

  private

  def advisor_student_params
    params.require(:user_advisor_student).permit(:advisor_id, :student_id)
  end


  def filter
    if params[:filter]
      params[:filter].to_sym
    else
      :requested
    end
  end
end
