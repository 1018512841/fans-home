# -*- encoding : utf-8 -*-
# 博客或者照片的上/下一个
module Pageable
  extend ActiveSupport::Concern

  def next_one
    self.class.where(id: { '$gt' => id }).order(id: :asc).limit(1).first
  end

  def previous_one
    self.class.where(id: { '$lt' => id }).order(id: :desc).limit(1).first
  end
end
