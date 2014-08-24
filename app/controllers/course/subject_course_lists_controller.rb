class Course::SubjectCourseListsController < ApplicationController
  load_and_authorize_resource

  def show
    if request.xhr?
      render partial: 'list_courses', layout: false
    else
      render 'show'
    end
  end

  def new
    @subject_course_list.group = Program::Group.find(params[:group_id])
  end

  def create
    if @subject_course_list.save
      if params[:saveandedit]
        redirect_to edit_subject_course_list_path(@subject_course_list)
      else
        redirect_to edit_program_group_path(@subject_course_list.group)
      end
    else
      flash[:alert] = @subject_course_list.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @subject_course_list.assign_attributes(subject_course_list_params)
    if @subject_course_list.save
      if params[:saveandedit]
        redirect_to edit_subject_course_list_path(@subject_course_list)
      else
        redirect_to edit_program_group_path(@subject_course_list.group)
      end
    else
      flash[:alert] = @subject_course_list.errors.full_messages
      render :edit
    end
  end

  def destroy
    @subject_course_list.destroy
    if request.xhr?
      return_json 'deleted'
    else
      _redirect_to :back
    end
  end

  private
  def subject_course_list_params
    params.require(:subject_course_list).permit(:level, :operation, :group_id).merge(subject: Course::Subject.find_by_name(params[:subject_course_list][:subject]))
  end


  def _
    @subject_course_list = Course::SubjectCourseList.find(params[:id])
  end
end
