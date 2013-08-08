class CourseController < ApplicationController
	def show
		@course = Course.find(params[:id])
	end

	def graph_embed 
		@course = Course.find(params[:id])
		render :layout => false
	end
	def json
		puts 'id: '+ params[:id].to_s
		course = Course.find(params[:id])
		render :json => course.as_json
	end
end