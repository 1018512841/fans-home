# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "tourist_posts/new" do
  before(:each) do
    assign(:tourist_post, stub_model(TouristPost,
      :city => "MyString",
      :coordinate => "MyString",
      :description => "MyString",
      :start_time => "MyString",
      :end_time => "MyString",
      :image_list => "MyString"
    ).as_new_record)
  end

  it "renders new tourist_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tourist_posts_path, "post" do
      assert_select "input#tourist_post_city[name=?]", "tourist_post[city]"
      assert_select "input#tourist_post_coordinate[name=?]", "tourist_post[coordinate]"
      assert_select "input#tourist_post_description[name=?]", "tourist_post[description]"
      assert_select "input#tourist_post_start_time[name=?]", "tourist_post[start_time]"
      assert_select "input#tourist_post_end_time[name=?]", "tourist_post[end_time]"
      assert_select "input#tourist_post_image_list[name=?]", "tourist_post[image_list]"
    end
  end
end
