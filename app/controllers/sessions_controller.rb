class SessionsController < ApplicationController
  before_action :require_no_authentication, only: [ :new, :create ]
  before_action :require_authentication, only: [ :destroy ]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path, notice: "Welcome, #{user.email}!"
    else
      redirect_to new_session_path, notice: "Incorrect email/password."
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
