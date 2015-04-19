# -*- encoding : utf-8 -*-
# 首页的面板
class Admin::Panel
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :desc, type: String
  field :weight, type: Integer
end
