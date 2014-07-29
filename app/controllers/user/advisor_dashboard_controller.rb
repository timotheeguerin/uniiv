class User::AdvisorDashboardController < ApplicationController
  def index
    @fullwidth = true
    @issues = current_user.assigned_issues.limit(20)

  end
end
