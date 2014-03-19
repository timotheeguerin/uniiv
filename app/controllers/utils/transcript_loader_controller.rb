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
    @url = 'https://horizon.mc_gill.ca/pban1/twbkwbis.P_WWWLogin' #TODO load by university
    begin
      html = Utils::Transcript::McGill::Authenticator.retrieve_transcript(params[:email], params[:password])
    rescue Utils::Transcript::McGill::AuthenticationError => e
      flash[:alert] = e.message
      render :parse
      return
    end

    process_html(html)
    render :parse_success
  end

  def parse_manual_show
    @url = 'https://horizon.mc_gill.ca/pban1/twbkwbis.P_WWWLogin'
    render :parse_manual
  end

  def parse_manual
    html = params[:html]
    process_html(html)
    render :parse_success
  end

  def process_html(html)
    results = Utils::Transcript::McGill::TranscriptParser.parse(html)
    @records = []
    @already_added = 0
    results.records.each do |result|
      if result[:grade].nil?
        if current_scenario.take_course(result[:course], result[:term])
          result[:success] = true
          result[:notice]= t('course.taking')
        else
          result[:errors]=current_scenario.errors.full_messages
          result[:success] = false
          current_scenario.errors.clear
        end
      else
        if current_user.has_completed_course?(result[:course])
          @already_added += 1
        else
          if current_user.complete_course(result[:course], result[:grade], result[:term])
            result[:success] = true
            result[:notice]= t('course.completed')
          else
            result[:errors]=current_user.errors.full_messages
            result[:success] = false
            current_user.errors.clear
          end
          @records << result
        end
      end
    end
  end
end
