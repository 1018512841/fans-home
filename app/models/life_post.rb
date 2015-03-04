require 'carrierwave/mongoid'
class LifePost
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  field :avatar
  attr_accessor :status
  attr_accessor :avatar_cache
  mount_uploader :avatar, AvatarUploader

  def self.life_posts_with(start, length)
    self.offset(start).limit(length)
  end

  def next_one
    self.class.where(:id => {:$gt => self.id}).order("id ASC").limit(1).first
  end

  def previous_one
    self.class.where(:id => {:$lt => self.id}).order("id DESC").limit(1).first
  end

  def next_one_path
    result = "/life_posts/"+self.next_one.id.to_s if self.next_one
    result || "####"
  end

  def previous_one_path
    result = "/life_posts/"+self.previous_one.id.to_s if self.previous_one
    result || "####"
  end

end
