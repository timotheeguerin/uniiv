class Admin::Utils::ProgramEditorController < ApplicationController
  def index
    @search = search
  end

  def search
    s= Search.from_params(params)
    Program.search_program(s)
    s
  end
end
