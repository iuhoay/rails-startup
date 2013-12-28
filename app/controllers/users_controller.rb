class UsersController < ApplicationController

  before_action :require_no_logined, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      login_as @user
      redirect_to root_url 
    else
      render :new
    end
  end

  private

    def signup_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
