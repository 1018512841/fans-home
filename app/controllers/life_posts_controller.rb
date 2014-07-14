class LifePostsController < ApplicationController

  before_action :set_life_post, only: [:show, :edit, :update, :destroy]
  before_action :user_admin_check, only: [:new, :create, :edit, :update, :destroy]


  # GET /life_posts
  # GET /life_posts.json
  def index
    @life_posts = LifePost.asc(:id).paginate(:page => params[:page], :per_page => 8)
  end

  # GET /life_posts/1
  # GET /life_posts/1.json
  def show
  end

  # GET /life_posts/new
  def new
    @life_post = LifePost.new
  end

  # GET /life_posts/1/edit
  def edit
  end

  # POST /life_posts
  # POST /life_posts.json
  def create
    @life_post = LifePost.new(life_post_params)

    content = @life_post.avatar.read
    respond_to do |format|
      if @life_post.save && stale?(etag: content, last_modified: @life_post.updated_at.utc, public: true)
        format.html { redirect_to @life_post, notice: 'Life post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @life_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @life_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /life_posts/1
  # PATCH/PUT /life_posts/1.json
  def update
      @life_post.set(life_post_params)

      content = @life_post.avatar.read
      respond_to do |format|
        if @life_post.save && stale?(etag: content, last_modified: @life_post.updated_at.utc, public: true)
          format.html { redirect_to @life_post, notice: 'Life post was successfully created.' }
          format.json { render action: 'show', status: :created, location: @life_post }
        else
          format.html { render action: 'edit' }
          format.json { render json: @life_post.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /life_posts/1
  # DELETE /life_posts/1.json
  def destroy
    @life_post.destroy
    respond_to do |format|
      format.html { redirect_to life_posts_url }
      format.json { head :no_content }
    end
  end

  def display_life_item_picture
    life_item_list = LifePost.get_life_post_by(params[:start], 3).to_a
    if params[:first_active] == "active" && life_item_list.size>0
      life_item_list[0].status = "active"
    end
    render :partial => "life_posts/life_picture_item",
           :locals => {:life_item_list => life_item_list}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_life_post
      @life_post = LifePost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def life_post_params
      params.require(:life_post).permit(:title, :body, :avatar, :avatar_cache)
    end

end
