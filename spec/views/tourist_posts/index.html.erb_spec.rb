require 'spec_helper'

describe "tourist_posts/index" do
  before(:each) do
    assign(:tourist_posts, [
      stub_model(TouristPost,
        :city => "City",
        :coordinate => "Coordinate",
        :description => "Description",
        :start_time => "Start Time",
        :end_time => "End Time",
        :image_list => "Image List"
      ),
      stub_model(TouristPost,
        :city => "City",
        :coordinate => "Coordinate",
        :description => "Description",
        :start_time => "Start Time",
        :end_time => "End Time",
        :image_list => "Image List"
      )
    ])
  end

  it "renders a list of tourist_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Coordinate".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Start Time".to_s, :count => 2
    assert_select "tr>td", :text => "End Time".to_s, :count => 2
    assert_select "tr>td", :text => "Image List".to_s, :count => 2
  end
end
