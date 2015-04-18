# -*- encoding : utf-8 -*-
class TouristImage
  include Mongoid::Document
  field :avatar
  embedded_in :tourist_post
  mount_uploader :avatar, AvatarUploader


  def destroy_image
    self.remove_avatar!
    self.save
  end
end
