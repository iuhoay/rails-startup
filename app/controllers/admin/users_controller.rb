class Admin::UsersController < ApplicationController
  layout 'admin'

  before_action :require_admin

  def index
    @users = User.recent.page(params[:page]).per(20)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :admin_users
  end

end
