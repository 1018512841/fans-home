# -*- encoding : utf-8 -*-
#encoding: utf-8
require "spec_helper"
describe LifePost do

  describe 'get_life_post_by' do
    describe 'LifePost in database is blank' do
      it 'return a blank array' do
        result = LifePost.life_posts_with(0, 3)
        result.should == []
      end
    end
    describe 'LifePost in database is not' do
      before do
        10.times do |n|
          LifePost.create({
                              title: n,
                              body: n,
                              picture_url: "#{n}.jpg"
                          })
        end
      end
      it 'return first three record' do
        result = LifePost.life_posts_with(0, 3)
        result.length.should == 3
        result[0].title.should == "0"
        result[2].title.should == "2"
      end
      it 'return secondary three record' do
        result = LifePost.life_posts_with(3, 3)
        result.length.should == 3
        result[0].title.should == "3"
        result[2].title.should == "5"
      end
    end
  end
end
