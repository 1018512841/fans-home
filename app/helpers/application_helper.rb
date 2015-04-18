# -*- encoding : utf-8 -*-
module ApplicationHelper
  def current_user_name
    current_user = User.find_by(id:session[:user])
    current_user ? current_user.user_name : "游客"
  end

  def current_is_admin?
    current_user && current_user.role == "admin"
  end

  def admin_time(time)
    time.strftime '%Y-%m-%d %H:%M:%S'
  end

  def time_format(time)
    time.strftime '%Y年 %_m月 %_d日'
  end
end
