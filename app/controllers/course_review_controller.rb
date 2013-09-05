class CourseReviewController < ApplicationController
  before_action :setup

  def setup
    @course = Course::Course.find(params[:course_id])
    @rating_criterias = Course::RatingCriteria.all
  end

  def show
  end

  def new
    @review = Course::Review.new
    @review.ratings.build
    @review.init_ratings
  end

  def new_graph_embed
    @review = Course::Review.new
    @review.ratings.build
    @review.init_ratings
    render :layout => false
  end

  def create
    @review = Course::Review.new(params[:course_review].permit!)
    @review.course = @course
    @review.user = current_user
    if @review.save
      if params[:graph_emebed]
        return_json 'review.added', :url => course_graph_emebed_path(@review.course.id)
      else
        redirect_to course_path(@review)
      end
    else
      render 'new'
    end

  end

  def create_review

  end

end
