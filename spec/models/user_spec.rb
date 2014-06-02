#encoding: utf-8
require "spec_helper"

describe User do
  before { @user = User.new({user_name: "name_test",
                             user_email: "test@qq.com",
                             password: "123456",
                             password_conformation: "123456"}) }
  describe "test for attributes" do
    subject { @user }
    it { should respond_to (:user_name) }
    it { should respond_to (:user_email) }
    it { should respond_to (:password) }
    it { should respond_to (:password_conformation) }
    it { should respond_to (:salt) }
    it { should respond_to (:encrypted_password) }

    it { should respond_to (:user_name) }
    it { should respond_to (:user_email) }
    it { should respond_to (:password) }
    it { should respond_to (:password_conformation) }
    it { should respond_to (:salt) }
    it { should respond_to (:encrypted_password) }
    it { should be_valid }

    describe "when name is not valid" do
      before { @user.user_name = "" }
      it { should_not be_valid }
    end
    describe "when name is not unique" do
      before { @user2 = User.new({user_name: "name_test",
                                  user_email: "test2@qq.com",
                                  password: "123456",
                                  password_conformation: "123456"})
      @user2.save
      @user.save
      }
      it { should_not be_valid }
    end

    describe "when email is not valid" do
      before { @user.user_email = "" }
      it { should_not be_valid }
    end
    describe "when emain is not unique" do
      before do
        @user2 = User.new({user_name: "name_test2",
                           user_email: "test@qq.com",
                           password: "123456",
                           password_conformation: "123456"})
        @user2.save
        @user.save
      end
      it { should_not be_valid }
    end
    describe "when email format is not valid" do
      before do
        @user.user_email = "123@123.com"
        @user.save
      end
      it { should_not be_valid }
    end

    describe "when password and password_confirmation" do
      before do
        @user.password = "123456"
        @user.password_conformation = "456789"
        @user.save
      end
      it { should_not be_valid }
    end
  end

end