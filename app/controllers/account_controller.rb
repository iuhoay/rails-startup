class AccountController < ApplicationController

  before_action :require_logined

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(update_params)
      flash[:success] = "修改成功"
      redirect_to :edit_account
    else
      render :edit
    end
  end

  private

    def update_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
