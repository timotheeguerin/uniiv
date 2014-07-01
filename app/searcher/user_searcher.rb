class UserSearcher
  def self.search(params)
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
end