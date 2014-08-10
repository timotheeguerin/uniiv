class Issue::IssuesController < ApplicationController
  load_and_authorize_resource
  def index
    @filters = params.clone
    @filters[:status] ||= :open
    @filters[:authorized_ids] = @issues.ids
    @issues = IssueSearcher.search(@filters)
  end

  def show
  end

  def new
    redirect_to new_user_advisor_student_path if current_user.student? and not current_user.has_an_advisor?
    @issue = Issue::Issue.new
    @issue.build_content
  end

  def create
    @issue = Issue::Issue.create(issue_params)
    if @issue.valid?
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @issue.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @issue.assign_attributes(issue_params)
    if @issue.save
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @issue.errors.full_messages
      render :edit
    end
  end

  def destroy
    @issue = Issue::Issue.find(params[:id])
    authorize! :destroy, Issue::Issue
    @issue.destroy
    redirect_to issues_path
  end

  def change_status
    @issue = Issue::Issue.find(params[:id])
    @issue.status = params[:status]
    if @issue.save
      flash[:notice] = t('issue.status.change.success', status: @issue.status)
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @issue.errors.full_messages
      redirect_to issue_path(@issue)
    end
  end

  def autocomplete_items
    json = {}
    json[:query] = params[:q]
    suggestions = []
    json[:suggestions] = suggestions
    IssueSearcher.search_items(params).each do |item|
      suggestion = {}
      suggestion[:value] = item.to_s
      suggestion[:data] = element_id(item)
      suggestions << suggestion
    end
    render :json => json.to_json
  end

  private
  def issue_params
    params.require(:issue).permit(:title, :assignee_id, content_attributes: [:text, :format]).merge(reporter_id: current_user.id)
  end

  def parse_items
    return [] unless params.key?(:items)
    params[:items].split(',').map { |x| from_element_id(x) }
  end
end
