class User::AdvisorStudentsController < ApplicationController
  def new
    @advisor_student = User::AdvisorStudent.new
  end

  def create
    @advisor_student = User::AdvisorStudent.new(advisor_student_params)
    @advisor_student.validated = true if current_user.advisor?
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
    @advisor_student.destroy
    redirect_to user_advisor_students_path
  end

  def validate
    @advisor_student = User::AdvisorStudent.find(params[:id])
    authorize! :validate, @advisor_student
    @advisor_student.validated = true
    @advisor_student.save
    redirect_to user_advisor_students_path
  end

  def advisor_student_params
    params.require(:user_advisor_student).permit(:advisor_id, :student_id)
  end
end
