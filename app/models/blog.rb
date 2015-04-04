class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  belongs_to :user

  scope :hots, ->{order(created_at: :desc).limit(5)}
  scope :recommends, ->{order(created_at: :desc).limit(5)}
end
