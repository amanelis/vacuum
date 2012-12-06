require 'integration/integration_helper'

describe HomeController do
  describe 'home#index' do
    it "has the proper content on the page" do
      visit '/'
      
      assert current_path == root_path
      # assert page.has_content?('Welcome to Blog')
    end
  end
end