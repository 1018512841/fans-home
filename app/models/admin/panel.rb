class Admin::Panel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :desc, type: String
  field :weight, type: Integer
end
