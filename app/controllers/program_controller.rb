class ProgramController < ApplicationController
	def show
		@program = Program.find(params[:id])
	end

	def graph_embed
		@program = Program.find(params[:id])
		render :layout => false
	end
end
