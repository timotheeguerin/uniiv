class User::AdvisorDashboardController < ApplicationController
  def index
    authorize! :view, :advisor_dashboard
    @fullwidth = true
    @reporters = current_user.student_with_most_issues
  end
end
