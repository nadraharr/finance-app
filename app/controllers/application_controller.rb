class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def require_no_authentication
    return if !current_user
    redirect_to root_path
  end

  def require_authentication
    return if current_user
    redirect_to root_path
  end

  def user_not_authorized
    redirect_back_or_to root_path, notice: "You are not authorized to perform this action!"
  end

  helper_method :current_user
end
