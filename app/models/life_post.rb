class LifePost
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :picture_url, String

end
