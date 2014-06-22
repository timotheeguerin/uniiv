class RichContentController < ApplicationController
  def markdown

    text = RichContent.new(:text => params[:text], :format => :markdown)
    render :text => text.to_html
  end
end
