# -*- encoding : utf-8 -*-
require "spec_helper"

describe Admin::PanelsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/panels").should route_to("admin/panels#index")
    end

    it "routes to #new" do
      get("/admin/panels/new").should route_to("admin/panels#new")
    end

    it "routes to #show" do
      get("/admin/panels/1").should route_to("admin/panels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/panels/1/edit").should route_to("admin/panels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/panels").should route_to("admin/panels#create")
    end

    it "routes to #update" do
      put("/admin/panels/1").should route_to("admin/panels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/panels/1").should route_to("admin/panels#destroy", :id => "1")
    end

  end
end
