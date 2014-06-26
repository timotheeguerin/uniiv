class Issue::IssuesController < ApplicationController
  def index

  end

  def show
    @issue = Issue::Issue.find(params[:id])
    authorize! :view, @issue
  end

  def new
    authorize! :create, Issue::Issue
    @issue = Issue::Issue.new
    @issue.build_content
  end

  def create
    authorize! :create, Issue::Issue
    @issue = Issue::Issue.create(issue_params)
    if @issue.valid?
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @issue.errors.full_messages
      render :new
    end
  end

  def edit
    @issue = Issue::Issue.find(params[:id])
    authorize! :update, Issue::Issue
  end

  def update
    @issue = Issue::Issue.find(params[:id])
    authorize! :update, Issue::Issue
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

  def issue_params
    params.require(:issue).permit(:title, :content_attributes => [:id, :text, :format]).merge(reporter_id: current_user.id)
  end
end
