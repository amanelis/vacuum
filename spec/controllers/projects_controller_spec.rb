require 'spec_helper'

describe ProjectsController do
  include Devise::TestHelpers

  describe "GET 'index'" do
    context "when logged in" do
      before(:each) do
        @user = Fabricate(:user, password: 'password123', password_confirmation: 'password123')
        sign_in @user
      end
    
      it "should be successful" do
        get 'index'
        response.should be_success
      end
    end
  end
  
  describe "GET 'index'" do
    context "when not logged in" do
      it "returns http success" do
        get 'index'
        response.should be_redirect
      end
    end
  end
  
  describe "GET 'new'" do
    context "when not logged in" do
      it "returns http success" do
        get 'new'
        response.should be_redirect
      end
    end
  end
end