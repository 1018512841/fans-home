# -*- encoding : utf-8 -*-
# 后台管理首页的面板
class Admin::PanelsController < AdminController
  before_action :set_admin_panel, only: [:show, :edit, :update, :destroy]
  set_tab :panel

  # GET /admin/panels
  # GET /admin/panels.json
  def index
    @admin_panels = Admin::Panel.order(weight: :desc).paginate(page: params[:page], per_page: 1)
  end

  # GET /admin/panels/1
  # GET /admin/panels/1.json
  def show
  end

  # GET /admin/panels/new
  def new
    @admin_panel = Admin::Panel.new
  end

  # GET /admin/panels/1/edit
  def edit
  end

  # POST /admin/panels
  # POST /admin/panels.json
  def create
    @admin_panel = Admin::Panel.new(admin_panel_params)

    respond_to do |format|
      if @admin_panel.save
        format.html { redirect_to @admin_panel, notice: 'Panel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_panel }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/panels/1
  # PATCH/PUT /admin/panels/1.json
  def update
    respond_to do |format|
      if @admin_panel.update(admin_panel_params)
        format.html { redirect_to @admin_panel, notice: 'Panel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/panels/1
  # DELETE /admin/panels/1.json
  def destroy
    @admin_panel.destroy
    respond_to do |format|
      format.html { redirect_to admin_panels_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_panel
    @admin_panel = Admin::Panel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_panel_params
    params.require(:admin_panel).permit(:title, :desc, :weight)
  end
end
