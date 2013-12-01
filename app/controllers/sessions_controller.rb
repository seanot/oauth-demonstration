class SessionsController < ApplicationController
  def new
  end

  def create
    # render :text => request.env['omniauth.auth'].to_yaml
    if auth = request.env['omniauth.auth']
      user = User.find_or_create_with_omniauth(auth)
      @identity = Identity.find_with_omniauth(auth)
      if @identity.nil?
        @identity = Identity.create_with_omniauth(auth, user)
      end

      if signed_in?
        if @identity.user == current_user
          flash[:notice] = "Already linked to that account."
          redirect_to :root
        else
          @identity.user = current_user
          @identity.save
          flash[:notice] = "Successfully linked to that account."
          redirect_to :root
        end
      else
        if @identity.user.present?
          self.current_user = @identity.user
          flash[:notice] = "Signed in."
          redirect_to :root
        else
          current_user = @identity.user
          flash[:notice] = "Thank you for registering."
          redirect_to :root
        end
      end
    else
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "Logged in."
        redirect_to :root
      else
        flash[:notice] = "Please re-enter your credentials."
        redirect_to new_user_path
      end
    end
  end

  def destroy
    self.current_user = nil
    flash[:notice] = "Signed out."
    redirect_to :root
  end

end