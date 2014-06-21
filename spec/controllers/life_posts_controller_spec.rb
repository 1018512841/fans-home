require 'spec_helper'
describe LifePostsController do
  describe 'display_life_item_picture' do
    it 'start from 0' do
      session[:default_locale] = "zh"
      params = {"start" => "0", "first_active" => "active"}.with_indifferent_access
      post :display_life_item_picture, params
      expect(response).to render_template "life_posts/_life_picture_item"
    end
  end
end