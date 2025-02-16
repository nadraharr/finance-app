class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

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
    redirect_back_or_to root_path, alert: "You are not authorized to perform this action!"
  end

  def handle_not_found
    render file: "public/404.html", status: :not_found, layout: false
  end

  helper_method :current_user
end
