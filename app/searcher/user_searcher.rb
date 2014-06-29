class UserSearcher
  def self.search(params)
    search = User.search do
      fulltext params[:q]
      if params[:role]
        role = Role.find_by_name(params[:role])
        with :role_ids, role.id
      end
    end
    search.results
  end
end