module DeviseHelper
  def devise_error_messages!
    flash.now[:alert]
    resource.errors.full_messages.each do |error|
      if flash.now[:alert].nil?
        flash.now[:alert] = ''
      end
      flash.now[:alert] += error + '<br/>'
    end
    nil
  end

end 