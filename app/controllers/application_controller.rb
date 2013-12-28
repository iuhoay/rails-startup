class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logined?, :current_user

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logined?
    !!current_user
  end

  def current_user
    @current_user ||= login_from_session
  end

  def login_from_session
    if session[:user_id].present?
      begin
        User.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def logout
    session.delete(:user_id)
  end
end
