require 'spec_helper'

describe ProjectsController do
  describe "GET 'index'" do
    context "when not logged in" do
      it "returns http success" do
        get 'index'
        response.should redirect_to(new_user_session_path) || redirect_to(login_path)
      end
    end
    
    context "when logged in" do
      
    end
  end
end