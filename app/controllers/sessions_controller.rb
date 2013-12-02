class SessionsController < ApplicationController
  def new
  end

  def create
    auth = Authentication.new(params, env['omniauth.auth'])
    if auth.authenticated?
      session[:user_id] = auth.user.id
      flash[:notice] = "Logged in."
      redirect_to :root
    else
      flash[:notice] = "Email or password invalid."
      render :new
    end
  end

  def destroy
    self.current_user = nil
    flash[:notice] = "Signed out."
    redirect_to :root
  end
end
