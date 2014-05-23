require 'spec_helper'

describe "life_posts/new" do
  before(:each) do
    assign(:life_post, stub_model(LifePost,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new life_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", life_posts_path, "post" do
      assert_select "input#life_post_title[name=?]", "life_post[title]"
    end
  end
end
