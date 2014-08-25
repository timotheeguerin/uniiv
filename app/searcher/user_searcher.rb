class UserSearcher < ApplicationSearcher
  def self.search(params)
    return search_advisor(params) if params[:type] == 'advisor'
    search = User.search do
      fulltext params[:q]
      if params[:role]
        role = Role.find_by_name(params[:role])
        with :role_ids, role.id
      end
      with :type, params[:type] if params.key?(:type)
    end
    search.results
  end

  def self.search_advisor(params)
    search = User::Advisor.search do
      fulltext params[:q]
      if params[:role]
        role = Role.find_by_name(params[:role])
        with :role_ids, role.id
      end
      if params[:student_id]
        student = User::Student.find_by_id(params[:student_id])
        with :student_ids, student.id
      end
    end
    search.results
  end
end