class User::AdvisorDashboardController < ApplicationController
  def index
    @fullwidth = true
    # @issues = current_user.assigned_issues.limit(20)
    @reporters = current_user.student_with_most_issues
  end
end
