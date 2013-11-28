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
      redirect_to :root, alert: "Thank you for regestering."
    else
      render :new, alert: "Something didn't work correctly. Please try again."
    end
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update_attributes(user_params)
    redirect_to :root
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end