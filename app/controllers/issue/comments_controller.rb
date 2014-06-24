class Issue::CommentsController < ApplicationController

  before_action :setup

  def setup
    @issue = Issue::Issue.find(params[:issue_id])
  end

  def index
  end

  def show
  end

  def new
    authorize! :comment, @issue
    @comment = Issue::Comment.new
    @comment.issue = @issue
    @comment.build_content
  end

  def create
    authorize! :comment, @issue
    @comment = Issue::Comment.new(comment_params)
    if @comment.save
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @comment.errors.full_messages
      render :new
    end
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:content_attributes => [:id, :text, :format])
    .merge(commenter_id: current_user.id, issue_id: @issue.id)
  end
end
