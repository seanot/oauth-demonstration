class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by(auth_hash)
    session[:user_id] = user.id
    redirect_to :root
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end