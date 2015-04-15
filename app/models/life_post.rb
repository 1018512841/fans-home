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

  scope :life_posts_with, ->(start, length) { offset(start).limit(length) }

  def next_one
    self.class.where(:id => {:$gt => self.id}).order("id ASC").limit(1).first
  end

  def previous_one
    self.class.where(:id => {:$lt => self.id}).order("id DESC").limit(1).first
  end

end
