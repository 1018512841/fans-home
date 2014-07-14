class TouristPostsController < ApplicationController
  before_action :set_tourist_post, only: [:show, :edit, :update, :destroy]
  before_action :user_admin_check, only: [:new, :create, :edit, :update, :upload_image, :destroy_image, :destroy]

  # GET /tourist_posts
  # GET /tourist_posts.json
  def index
    @tourist_posts = TouristPost.all.paginate(:page => params[:page], :per_page => 8)
  end

  # GET /tourist_posts/1
  # GET /tourist_posts/1.json
  def show
  end

  # GET /tourist_posts/new
  def new
    @tourist_post = TouristPost.new
  end

  # GET /tourist_posts/1/edit
  def edit
  end

  # POST /tourist_posts
  # POST /tourist_posts.json
  def create
    @tourist_post = TouristPost.new(tourist_post_params)
    @tourist_post.tourist_images = []
    image = TouristImage.new({avatar: params[:avatar]})
    image.avatar.read
    image.tourist_post = @tourist_post
    if image.save
      # @tourist_post.tourist_images.push(image)
    end
    respond_to do |format|
      if @tourist_post.save
        image0_id = @tourist_post.tourist_images[0]
        image0 = TouristImage.find(image0_id.to_s)
        format.html { redirect_to @tourist_post, notice: 'Tourist post was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /tourist_posts/1
  # PATCH/PUT /tourist_posts/1.json
  def update
    respond_to do |format|
      if @tourist_post.update(tourist_post_params)
        format.html { redirect_to @tourist_post, notice: 'Tourist post was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def upload_image
    selected = TouristPost.find(params[:tourist_post_id])
    result = selected.add_image(params[:file]) if selected
    render :json => ActiveSupport::JSON.encode(result)
  end

  def destroy_image
    tourist = TouristPost.find(params[:tourist_id])
    images = tourist.tourist_images.select { |e| e.id.to_s == params[:image_id] }
    if images.length > 0
      images[0].destroy_image
    end
    render :json => {}
  end

  # DELETE /tourist_posts/1
  # DELETE /tourist_posts/1.json
  def destroy
    @tourist_post.tourist_images.each do |image|
      image.destroy_image
    end
    @tourist_post.destroy
    respond_to do |format|
      format.html { redirect_to tourist_posts_url }
    end
  end

  def tourist_city
    city = [
        {latLng: [34.62, 112.45], name: '河南 - 洛阳  家'},
        {latLng: [34.74, 113.66], name: '河南 - 郑州  2010,2011,2012'},

        {latLng: [34.261792, 117.184811], name: '徐州市  2010-2014'},
        {latLng: [38.97, 121.53], name: '辽宁 - 大连  2010-2014'},
        {latLng: [29.88, 121.64], name: '浙江 - 宁波  2014.04'}
    ]
    render :json => city
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tourist_post
    @tourist_post = TouristPost.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tourist_post_params
    params.require(:tourist_post).permit(:city, :coordinate, :description, :start_time, :end_time)
  end
end
