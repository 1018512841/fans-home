module ApplicationHelper
  def get_current_user_name
    current_user = User.find_by(id:session[:user])
    return current_user ? current_user.user_name : I18n.t("visitor")
  end

  def get_current_user
    return User.find_by(id:session[:user])
  end

  def current_is_login?
    return User.find_by(id:session[:user]).present?
  end

  def current_is_admin?
    return get_current_user && get_current_user.role == "admin"
  end
end
