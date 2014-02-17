class Admin::Utils::ProgramEditorController < ApplicationController
  def index
    @search = search
  end


  def program_params
    params.require(:program).permit(:name, :type_id, :faculty_id)
  end

  def search
    s= Search.from_params(params)
    Program.search_program(s)
    s
  end
end
