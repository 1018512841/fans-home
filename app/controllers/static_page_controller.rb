class StaticPageController < ApplicationController
  def index
    @panel = Admin::Panel.order(weight: :desc).first
    @counts = Array.new(4,0)
    @counts[0] = LifePost.count
    @counts[1] = Blog.count
    @counts[2] = TouristPost.count
    @counts[3] = 0
  end

  def test

  end

end
