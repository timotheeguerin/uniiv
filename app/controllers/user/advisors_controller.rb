class User::AdvisorsController < ApplicationController

  def issues
    setup_filters
    @issues = IssueSearcher.search(@filters)
    render 'issue/issues/index'
  end

  def student_issues
    setup_filters
    @filters[:reporter_id] = params[:student_id]
    @filters[:lock_reporter] = true
    @issues = IssueSearcher.search(@filters)
    render 'issue/issues/index'
  end

  def setup_filters
    @filters = params.clone
    @filters[:status] ||= :open
    @filters[:assignee_id] = params[:id]
    @filters[:lock_assignee] = true
  end
end
