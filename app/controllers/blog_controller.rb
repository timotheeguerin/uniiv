class BlogController < ApplicationController

  def index
    @posts = Blog.last([5,Blog.count].min)
  end

  def show
    blog = Blog.find(params[:blog_id])
    @title = blog.title
    @content = blog.content
  end

end
