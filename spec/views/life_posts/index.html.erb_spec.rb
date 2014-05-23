require 'spec_helper'

describe "life_posts/index" do
  before(:each) do
    assign(:life_posts, [
      stub_model(LifePost,
        :title => "Title"
      ),
      stub_model(LifePost,
        :title => "Title"
      )
    ])
  end

  it "renders a list of life_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
