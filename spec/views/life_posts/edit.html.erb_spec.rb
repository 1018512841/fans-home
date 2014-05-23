require 'spec_helper'

describe "life_posts/edit" do
  before(:each) do
    @life_post = assign(:life_post, stub_model(LifePost,
      :title => "MyString"
    ))
  end

  it "renders the edit life_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", life_post_path(@life_post), "post" do
      assert_select "input#life_post_title[name=?]", "life_post[title]"
    end
  end
end
