# -*- encoding : utf-8 -*-
require 'spec_helper'

describe UsersController do

  describe "GET users" do
    describe "with no session[:default_locale]" do
      it "returns default language of zh" do
        session[:default_locale] = nil
        request.env['HTTP_ACCEPT_LANGUAGE'] = "zh--"
        get 'new'
        session[:default_locale].should == "zh"
        I18n.locale.should == "zh".to_sym
      end
      it "returns default language of en" do
        session[:default_locale] = nil
        request.env['HTTP_ACCEPT_LANGUAGE'] = "en--"
        get 'new'
        session[:default_locale].should == "en"
        I18n.locale.should == "en".to_sym
      end

      it "returns default language of other" do
        session[:default_locale] = nil
        request.env['HTTP_ACCEPT_LANGUAGE'] = "es--"
        get 'new'
        session[:default_locale].should == "en"
        I18n.locale.should == "en".to_sym
      end
    end

    describe "with session[:default_locale]" do
      it "returns default language of zh" do
        session[:default_locale] = "zh"
        request.env['HTTP_ACCEPT_LANGUAGE'] = "en--"
        get 'new'
        session[:default_locale].should == "zh"
      end
      it "returns default language of en" do
        session[:default_locale] = "en"
        request.env['HTTP_ACCEPT_LANGUAGE'] = "zh--"
        get 'new'
        session[:default_locale].should == "en"
      end
    end
  end

end
