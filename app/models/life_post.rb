class LifePost
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :picture_url, String
  attr_accessor :status

  def self.get_life_post_by(start,length)
    LifePost.offset(start).limit(length).all
  end

end
