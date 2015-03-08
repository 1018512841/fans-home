class Admin::Panel
  include Mongoid::Document
  field :title, type: String
  field :desc, type: String
  field :weight, type: Integer
end
