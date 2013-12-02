class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for registering."
      redirect_to :root
    else
      flash[:notice] = "Something didn't work correctly. Please try again."
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    flash[:notice] = "User attributes updated."
    redirect_to :root
  end

  def destroy
    user = current_user
    user.destroy
    self.current_user = nil
    flash[:notice] = "Account deleted."
    redirect_to :root
  end

  private
    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

end