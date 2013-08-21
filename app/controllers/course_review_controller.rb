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
    if create_review
      redirect_to course_review_path(@review)
    else
      render 'new'
    end

  end

  def create_graph_embed
    if create_review
      redirect_to course_review_path(@review)
    else
      render 'new_graph_embed'
    end
  end

  def create_review
    @review = Course::Review.new(params[:course_review].permit!)
    @review.course = @course
    @review.save
  end

end
