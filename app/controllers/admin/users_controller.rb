# -*- encoding : utf-8 -*-
# 后台管理用户
class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  set_tab :user

  def index
    @users = User.all
  end

  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
