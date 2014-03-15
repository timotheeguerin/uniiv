class Utils::TranscriptLoaderController < ApplicationController
  before_action :setup

  def setup
    authorize! :edit, current_user
  end

  def index

  end

  def parse_show

    render :parse
  end

  def parse
    @url = 'https://horizon.mcgill.ca/pban1/twbkwbis.P_WWWLogin' #TODO load by university
  end

  def parse_manual_show
    @url = 'https://horizon.mcgill.ca/pban1/twbkwbis.P_WWWLogin'
    render :parse_manual
  end

  def parse_manual
    html = params[:html]
  end
end
