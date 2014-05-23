require 'spec_helper'

describe "life_posts/show" do
  before(:each) do
    @life_post = assign(:life_post, stub_model(LifePost,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
