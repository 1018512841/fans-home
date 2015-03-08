class AdminController < ApplicationController
  before_action :check_admin
  layout 'admin'

  private
  def check_admin
    unless current_is_admin_role
      if request.xhr?
        render status: :unauthorized
      else
        redirect_to :root, status: :unauthorized
      end
    end
  end


end
