class Admin::Utils::ProgramEditorController < ApplicationController
  def index
    authorize! :edit, Program
    @search = search
  end

  def search
    s= Utils::Search.from_params(params)
    Program::Program.search_program(s)
    s
  end
end
