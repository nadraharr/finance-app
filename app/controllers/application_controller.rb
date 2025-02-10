class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def require_no_authentication
    return if !current_user
    redirect_to root_path
  end

  def require_authentication
    return if current_user
    redirect_to root_path
  end

  helper_method :current_user
end
