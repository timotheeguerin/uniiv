module DeviseHelper
def devise_error_messages!
    flash.now[:alert] = ""
    resource.errors.full_messages.each do |error|
      flash.now[:alert] += "<div style='font-weight:bold;'>" + error + "</div>"
    end
    return nil
  end
end 