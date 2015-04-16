class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_i18n_session
  before_action :set_default_login, :except => ["login", "logout", "create"]
  helper_method :current_user, :current_is_admin_role

  private

  def set_i18n_session
    unless session[:default_locale]
      accept_language = get_default_locale(request.env['HTTP_ACCEPT_LANGUAGE'])
      set_locale(accept_language)
    end
  end

  def get_default_locale(language_request)
    language = language_request.scan(/^[a-z]{2}/).first
    if language.downcase == "zh"
      language = "zh"
    else
      language = 'en'
    end
    language
  end

  def set_locale(locale)
    I18n.locale = session[:default_locale] = locale
  end

  def set_session_cookie(user, remember_me)
    session[:user] = user.id
    if remember_me== "yes"
      cookies[:user] = { :value => user.id, :expires => 1.week.from_now }
    end
  end

  def set_default_login
    if cookies[:user].present?
      session[:user] = cookies[:user]
    end
  end

  def set_logout
    session[:user] = cookies[:user] = nil
  end

  def current_is_admin_role
    user = User.find(session[:user]) if session[:user]
    is_admin_user = false
    if user.present?
      is_admin_user = user.role == "admin"
    end
    is_admin_user
  end

  def current_user
    @c_user || @c_user = User.find_by(id:session[:user])
  end

  def current_user?(user)
    session[:user] == user.id.to_s
  end


  def user_admin_check
    unless current_is_admin_role
      redirect_to root_url
    end
  end
end
