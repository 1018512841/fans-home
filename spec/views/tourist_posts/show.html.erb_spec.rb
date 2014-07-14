require 'spec_helper'

describe "tourist_posts/show" do
  before(:each) do
    @tourist_post = assign(:tourist_post, stub_model(TouristPost,
      :city => "City",
      :coordinate => "Coordinate",
      :description => "Description",
      :start_time => "Start Time",
      :end_time => "End Time",
      :image_list => "Image List"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    rendered.should match(/Coordinate/)
    rendered.should match(/Description/)
    rendered.should match(/Start Time/)
    rendered.should match(/End Time/)
    rendered.should match(/Image List/)
  end
end
