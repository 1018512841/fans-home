class TouristPost
  include Mongoid::Document
  field :city, type: String
  field :coordinate, type: String
  field :description, type: String
  field :start_time, type: String
  field :end_time, type: String
  embeds_many :tourist_images

  def add_image(file)
    result = ""
    image = TouristImage.new({avatar: file})
    image.avatar.read
    image.tourist_post = self
    image.save
    result
  end

  def get_image_cover_url
    if self.tourist_images.length > 0
      self.tourist_images[0].avatar.thumb.url
    else
      "/images/bootstrap-mdo-sfmoma-01.jpg"
    end
  end

  def get_normal_images
    if self.tourist_images.length > 0
      self.tourist_images[1..-1]
    else
      []
    end
  end
end
