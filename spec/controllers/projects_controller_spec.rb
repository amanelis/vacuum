require 'spec_helper'

describe ProjectsController do
  describe "GET 'index'" do
    context "when not logged in" do
      #
      # Response/Redirect
      it "returns http success" do
        get 'index'
        response.should redirect_to(new_user_session_path) || redirect_to(login_path)
      end
    end
  end
end