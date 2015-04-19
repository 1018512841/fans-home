# -*- encoding : utf-8 -*-
# 旅游表
class TouristPost
  include Mongoid::Document
  field :city, type: String
  field :coordinate, type: String
  field :description, type: String
  field :start_time, type: String
  field :end_time, type: String
  embeds_many :tourist_images

  def add_image(file)
    image = TouristImage.new(avatar: file)
    image.avatar.read
    image.tourist_post = self
    image.save
  end

  def image_cover_url
    if tourist_images.length > 0
      tourist_images[0].avatar.thumb.url
    else
      '/images/bootstrap-mdo-sfmoma-01.jpg'
    end
  end

  def normal_images
    tourist_images[1..-1] || []
  end

  def format_coordinate
    coordinate.split(/,/).map(&:to_f).reverse
  end

  def map_title
    "#{city} (#{start_time}-#{end_time})"
  end
end
