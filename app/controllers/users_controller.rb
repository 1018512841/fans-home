class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_manager_user, :only => [:index, :user_list, :destroy_users]
  before_action :check_current_user, :only => [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end


  def user_list
    users_array = User.get_user_list
    render :json => {data: users_array}
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    #100.times do |i|
    #  user_params = {user_name:"user_" + i.to_s,
    #                 user_email:"user_" + i.to_s + "@qq.com",
    #                 password:"user_" + i.to_s,
    #                 password_confirmation:"user_" + i.to_s,
    #
    #  }
    #  user = User.new(user_params)
    #  user.save
    #end

    respond_to do |format|
      if @user.save
        set_logout
        set_session_cookie(@user, "")
        format.html { redirect_to @user, notice: I18n.t("create_user_success") }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: I18n.t("update_user_success") }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy_users
    status, message = User.destroy_user_by_ids(params[:user_ids])
    render :json => {status: status, message: message}
  end


  def destroy
    if current_user?(@user)
      redirect_to @user, notice: I18n.t("delete_self_error")
    end

    @user.destroy
    respond_to do |format|
      flash[:notice] = I18n.t("delete_ok")
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def login
    @back_url = params[:back_url].blank? ? root_url : params[:back_url]
  end

  def check_login
    user = User.where(:user_email => params[:user_email]).first
    result = User.check_user_login(user, params[:user_password])
    if result[:status] == "success"
      set_session_cookie(user, params[:remember_me])
    end
    render :json => result
  end

  def logout
    set_logout
    redirect_to root_url
  end

  def permission_required

  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:user_name,
                                 :password,
                                 :user_email,
                                 :password_confirmation,
                                 :role)
  end

  def check_manager_user
    render "permission_required" unless current_is_admin_role
  end

  def check_current_user
    if session[:user] != params[:id] && !current_is_admin_role
      render "permission_required"
    end
  end
end
