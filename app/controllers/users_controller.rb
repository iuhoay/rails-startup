class UsersController < ApplicationController

  before_action :require_no_logined, only: [:create, :new]
  before_action :find_user_by_email, only: [:show, :edit]

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

  def index
    @users = User.recent.page(params[:page]).per(16)
  end

  def show
  end

  private

    def signup_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def find_user_by_email
      @user = User.where(name: params[:name]).first || not_found
    end

end
