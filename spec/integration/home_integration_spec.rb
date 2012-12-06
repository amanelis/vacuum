require 'integration/integration_helper'

describe HomeController do  
  describe 'home#index' do
    context 'when not logged in' do
      it "has proper title" do
        visit '/'
        assert current_path == root_path
        assert page.has_content?('Vacuum')
      end
      
      it "has proper links for sign up" do
        visit '/'
        assert current_path == root_path
        assert page.has_content?('Home')
        assert page.has_content?('Login')
        assert page.has_content?('Sign up')
      end
    end
  end
end