class LifePost
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :status

  field :title, type: String
  field :body, type: String
  field :picture_url, type: String

  def self.get_life_post_by(start, length)
    self.offset(start).limit(length)
  end

  def next_one
    self.class.where(:id => {:$gt => self.id}).order("id ASC").limit(1).first
  end

  def previous_one
    self.class.where(:id => {:$lt => self.id}).order("id ASC").limit(1).first
  end

  def next_one_path
    result = "/life_posts/"+self.next_one.id.to_s if self.next_one
    return result || "####"
  end

  def previous_one_path
    result = "/life_posts/"+self.previous_one.id.to_s if self.previous_one
    return result || "####"
  end

end
