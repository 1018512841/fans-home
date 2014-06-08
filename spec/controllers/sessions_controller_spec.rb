require 'spec_helper'

describe SessionsController do

  before do
    session[:default_locale] = "en"
    I18n.locale = "en"
  end
  describe "params[:locale] is invalid" do
    describe "params[:locale] is blank" do
      it "should change nothing" do
        post 'change_locale'
        session[:default_locale].should == "en"
        I18n.locale.should == "en".to_sym
      end
      it "should change nothing" do
        post 'change_locale', {:locale => ""}
        session[:default_locale].should == "en"
        I18n.locale.should == "en".to_sym
      end
    end
    describe "params[:locale] value is wrongs" do
      it "should change nothing" do
        post 'change_locale', {:locale => "xx"}
        session[:default_locale].should == "en"
        I18n.locale.should == "en".to_sym
      end
    end
  end
  describe "params[:locale] value is valid" do
    describe "params[:locale] value is change" do
      it "should change nothing" do
        post 'change_locale', {:locale => "zh"}
        session[:default_locale].should == "zh"
        I18n.locale.should == "zh".to_sym
      end
    end
    describe "params[:locale] value is not change" do
      it "should change nothing" do
        post 'change_locale', {:locale => "en"}
        session[:default_locale].should == "en"
        I18n.locale.should == "en".to_sym
      end
    end
  end
end
