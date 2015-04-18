# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "admin/panels/new" do
  before(:each) do
    assign(:admin_panel, stub_model(Admin::Panel,
      :title => "MyString",
      :desc => "MyText",
      :weight => 1
    ).as_new_record)
  end

  it "renders new admin_panel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_panels_path, "post" do
      assert_select "input#admin_panel_title[name=?]", "admin_panel[title]"
      assert_select "textarea#admin_panel_desc[name=?]", "admin_panel[desc]"
      assert_select "input#admin_panel_weight[name=?]", "admin_panel[weight]"
    end
  end
end
