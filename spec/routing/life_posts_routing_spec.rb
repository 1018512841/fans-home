require "spec_helper"

describe LifePostsController do
  describe "routing" do

    it "routes to #index" do
      get("/life_posts").should route_to("life_posts#index")
    end

    it "routes to #new" do
      get("/life_posts/new").should route_to("life_posts#new")
    end

    it "routes to #show" do
      get("/life_posts/1").should route_to("life_posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/life_posts/1/edit").should route_to("life_posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/life_posts").should route_to("life_posts#create")
    end

    it "routes to #update" do
      put("/life_posts/1").should route_to("life_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/life_posts/1").should route_to("life_posts#destroy", :id => "1")
    end

  end
end
