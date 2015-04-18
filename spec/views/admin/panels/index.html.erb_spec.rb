# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "admin/panels/index" do
  before(:each) do
    assign(:admin_panels, [
      stub_model(Admin::Panel,
        :title => "Title",
        :desc => "MyText",
        :weight => 1
      ),
      stub_model(Admin::Panel,
        :title => "Title",
        :desc => "MyText",
        :weight => 1
      )
    ])
  end

  it "renders a list of admin/panels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
