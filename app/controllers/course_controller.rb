class CourseController < ApplicationController
	def show
		@course = Course::Course.find(params[:id])
	end

	def graph_embed 
		@course = Course::Course.find(params[:id])
		render :layout => false
	end
	def json
		puts 'id: '+ params[:id].to_s
		course = Course::Course.find(params[:id])
		render :json => course.as_json
	end
end