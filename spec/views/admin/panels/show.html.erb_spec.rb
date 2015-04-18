# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "admin/panels/show" do
  before(:each) do
    @admin_panel = assign(:admin_panel, stub_model(Admin::Panel,
      :title => "Title",
      :desc => "MyText",
      :weight => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
