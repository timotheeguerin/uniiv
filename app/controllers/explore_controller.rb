class ExploreController < ApplicationController
  def index
    
  end

  def search

  end

  def get_results
    results = []
    if params[:program_only]
    elsif  params[:course_only]
    else
      results = Sunspot.search model_list do |query|
        query.fulltext params[:q]
      end
    end

  end
end
