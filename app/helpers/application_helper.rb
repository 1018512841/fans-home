module ApplicationHelper
  def get_current_user_name
    current_user = User.find(session[:user])
    return current_user ? current_user.user_name : I18n.t("visitor")
  end

  def get_current_user
    return User.find(session[:user])
  end

  def current_is_login?
    return User.find(session[:user]).present?
  end
end
