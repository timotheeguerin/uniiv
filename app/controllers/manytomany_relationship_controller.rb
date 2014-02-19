class ManytomanyRelationshipController < ApplicationController
  include ManytomanyRelationshipHelper

  before_action :setup

  def setup
    mparams = {}
    mparams[:model] = params[:model]
    mparams[:model_id] = params[:model_id]
    mparams[:relation] = params[:relation]
    @relation = get_relation(mparams)
  end

  def list

  end

  def delete
    element = @relation[:relation_class].find(params[:id])
    if element.nil?
    else
      @relation[:list].delete(element)
      redirect_to :back
    end
  end

  #Return the relation list

end
