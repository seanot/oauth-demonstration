class SessionsController < ApplicationController
  def new
  end

  def create
    if auth = env['omniauth.auth']
      @user = User.where(auth.slice(:info['email'])).first_or_initialize.tap do |user|
        puts "==========#{user.name} #{user.email}"
        user.name = auth.info.name
        user.email = auth.info.email if user.email == nil
        user.save!
        identity = Identity.find_by_provider_and_uid(auth['provider'], auth['uid'].to_s)
        if identity.nil?
          identity = Identity.create(uid: auth['uid'], provider: auth['provider'], user_id: user.id)
        end
      end
      session[:user_id] = @user.id
      flash[:notice] = "Logged in."
      redirect_to :root
    else
      user = User.find_by(email: params[:email])
      @user = user if user && user.authenticate(params[:email], params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in."
      redirect_to :root
    end
  end


  #     if signed_in?
  #       if @identity.user == current_user
  #         flash[:notice] = "Already linked to that account."
  #         redirect_to :root
  #       else
  #         @identity.user = current_user
  #         @identity.save
  #         flash[:notice] = "Successfully linked to that account."
  #         redirect_to :root
  #       end
  #     else
  #       if @identity.user.present?
  #         self.current_user = @identity.user
  #         flash[:notice] = "Signed in."
  #         redirect_to :root
  #       else
  #         current_user = @identity.user
  #         flash[:notice] = "Thank you for registering."
  #         redirect_to :root
  #       end
  #     end
  #   else
  #     #
  #       session[:user_id] = user.id
  #
  #     else
  #       flash[:notice] = "Please re-enter your credentials."
  #       redirect_to new_user_path
  #     end
  #   end
  # end

  def destroy
    self.current_user = nil
    flash[:notice] = "Signed out."
    redirect_to :root
  end

end