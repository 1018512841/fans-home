# -*- encoding : utf-8 -*-
# 旅游图片
class TouristImage
  include Mongoid::Document
  field :avatar
  embedded_in :tourist_post
  mount_uploader :avatar, AvatarUploader

  def destroy_image
    remove_avatar!
    save
  end
end
