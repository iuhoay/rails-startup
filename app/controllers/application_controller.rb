class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logined?, :current_user

  before_action :set_locale

  def set_locale
    I18n.locale = user_locale
    cookies[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    cookies[:locale] = I18n.locale = I18n.default_locale
  end

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logined?
    !!current_user
  end

  def current_user
    @current_user ||= login_from_session || login_from_cookies
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
    forget_me
  end

  def remember_me
    cookies[:remember_token] = { value: current_user.remember_token, expires: 2.weeks.from_now }
  end

  def forget_me
    cookies.delete(:remember_token)
  end

  def login_from_cookies
    if cookies[:remember_token].present?
      if user = User.find_by_remember_token(cookies[:remember_token])
        session[:user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def require_no_logined
    if logined?
      flash[:alert] = "你已经登录了"
      redirect_to root_url
    end
  end

  def require_logined
    unless logined?
      flash[:alert] = "你还没有登录"
      redirect_to signin_url
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = "你没有权限"
      redirect_to root_url
    end
  end

  private

    def user_locale
      params[:locale] || cookies[:locale] || http_head_locale || I18n.default_locale
    end

    def http_head_locale
      http_accept_language.language_region_compatible_from(I18n.available_locales)
    end
end
