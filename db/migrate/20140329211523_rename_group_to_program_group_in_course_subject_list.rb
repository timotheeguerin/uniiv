class RenameGroupToProgramGroupInCourseSubjectList < ActiveRecord::Migration
  def change
    rename_column :course_subject_course_lists, :group_id, :program_group_id
  end
end
