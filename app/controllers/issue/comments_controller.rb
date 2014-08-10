class Issue::CommentsController < ApplicationController
  load_and_authorize_resource :issue, class: 'Issue::Issue'
  load_and_authorize_resource :through => :issue

  def new
    @comment.build_content
  end

  def create
    @comment = Issue::Comment.new(comment_params)
    if @comment.save
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @comment.errors.full_messages
      render :new
    end
  end

  def edit
    if params[:embed_edit]
      render :partial => 'form', locals: {comment: @comment}
    end
  end

  def update
    @comment.assign_attributes(comment_params)
    if @comment.save
      redirect_to issue_path(@issue)
    else
      flash[:alert] = @comment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to issue_path(@issue)
  end

  private

  def comment_params
    params.require(:comment).permit(:content_attributes => [:id, :text, :format])
    .merge(commenter_id: current_user.id, issue_id: @issue.id)
  end
end
