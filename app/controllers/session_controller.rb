class SessionController < ApplicationController

  before_action :require_no_logined, except: :destroy

  def new
  end

  def create
    user = User.find_by_email(params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      flash[:success] = "Welcome back #{user.name}"
      login_as user
      remember_me if params[:remember_me]
      redirect_to root_url
    else
      flash.now[:error] = "登录邮箱或密码错误"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

end
