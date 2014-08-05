class User::AdvisorDashboardController < ApplicationController
  def index
    @fullwidth = true
    @reporters = current_user.student_with_most_issues
  end
end
