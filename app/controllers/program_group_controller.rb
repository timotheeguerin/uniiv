class ProgramGroupController < ApplicationController
	def show
		@group = ProgramGroup.find(params[:id])
	end

	def graph_embed
		@group = ProgramGroup.find(params[:id])
		render :layout => false
	end
end
