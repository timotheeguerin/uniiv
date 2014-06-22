class IssueController < ApplicationController
  def index

  end


  def show
    @issue = Issue::Issue.find(params[:id])
    authorize! :view, @issue
  end

  def new
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


  def issue_params
    params.require(:issue_issue).permit(:title, :content_attributes => [:id, :text, :format]).merge(reporter_id: current_user.id)
  end
end
