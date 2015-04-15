require 'carrierwave/mongoid'
class LifePost
  include Mongoid::Document
  include Mongoid::Timestamps
  include Pageable

  field :title, type: String
  field :body, type: String
  field :avatar
  attr_accessor :status
  attr_accessor :avatar_cache
  mount_uploader :avatar, AvatarUploader

  scope :life_posts_with, ->(start, length) { offset(start).limit(length) }



end
