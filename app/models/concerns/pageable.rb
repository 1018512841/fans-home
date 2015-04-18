# -*- encoding : utf-8 -*-
module Pageable
  extend ActiveSupport::Concern
  def next_one
    self.class.where(:id => {:$gt => self.id}).order("id ASC").limit(1).first
  end

  def previous_one
    self.class.where(:id => {:$lt => self.id}).order("id DESC").limit(1).first
  end
end
