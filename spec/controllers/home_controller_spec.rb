require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    #
    # Response code
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
end