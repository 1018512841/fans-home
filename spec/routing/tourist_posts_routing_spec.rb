# -*- encoding : utf-8 -*-
require "spec_helper"

describe TouristPostsController do
  describe "routing" do

    it "routes to #index" do
      get("/tourist_posts").should route_to("tourist_posts#index")
    end

    it "routes to #new" do
      get("/tourist_posts/new").should route_to("tourist_posts#new")
    end

    it "routes to #show" do
      get("/tourist_posts/1").should route_to("tourist_posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tourist_posts/1/edit").should route_to("tourist_posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tourist_posts").should route_to("tourist_posts#create")
    end

    it "routes to #update" do
      put("/tourist_posts/1").should route_to("tourist_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tourist_posts/1").should route_to("tourist_posts#destroy", :id => "1")
    end

  end
end
