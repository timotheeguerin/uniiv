class GroupSubjectCourseListController < ApplicationController


  def new
    authorize! :edit, Course::SubjectCourseList
    @subject_course_list = Course::SubjectCourseList.new
    @subject_course_list.program_group = Program::Group.find(params[:program_group])
  end

  def create
    authorize! :edit, Course::SubjectCourseList
    @subject_course_list = Course::SubjectCourseList.new
    set_with_params(@subject_course_list)
    if @subject_course_list.save
      if params[:saveandedit]
        redirect_to group_subject_course_list_new_path(@subject_course_list)
      else
        redirect_to program_group_edit_path(@subject_course_list.program_group)
      end
    else
      flash[:alert] = @subject_course_list.errors.full_messages
      render :new
    end
  end

  def edit
    @subject_course_list = Course::SubjectCourseList.find(params[:id])
  end

  def update
    @subject_course_list = Course::SubjectCourseList.find(params[:id])
    if @subject_course_list.save
      if params[:saveandedit]
        redirect_to group_subject_course_list_edit_path(@subject_course_list)
      else
        redirect_to program_group_edit_path(@subject_course_list.program_group)
      end
    else
      flash[:alert] = @subject_course_list.errors.full_messages
      render :edit
    end
  end

  def delete
    @subject_course_list = Course::SubjectCourseList.find(params[:id])
    @subject_course_list.destroy
    if request.xhr?
      return_json 'Deleted'
    else
      _redirect_to :back
    end
  end

  def set_with_params(subject_course_list)
    subject_course_list.level = params[:level]
    subject_course_list.operation = params[:operation]
    subject_course_list.subject = Course::Subject.find_by_name(params[:subject])
    subject_course_list.program_group = Program::Group.find(params[:program_group])
  end
end
