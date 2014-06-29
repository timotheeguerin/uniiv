class User::UsersController < ApplicationController
  def autocomplete
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    UserSearcher.search(params).each do |user|
      suggestion = {}
      suggestion[:value] = user.primary_email.to_s
      suggestion[:data] = user.id
      suggestions << suggestion
    end
    render :json => json.to_json
  end
end
