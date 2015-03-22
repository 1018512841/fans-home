module ApplicationHelper
  def get_current_user_name
    current_user = User.find_by(id:session[:user])
    current_user ? current_user.user_name : "游客"
  end

  def get_current_user
    User.find_by(id:session[:user])
  end

  def current_is_login?
    User.find_by(id:session[:user]).present?
  end

  def current_is_admin?
    get_current_user && get_current_user.role == "admin"
  end

  def admin_time(time)
    time.strftime '%Y-%m-%d %H:%M:%S'
  end
end
