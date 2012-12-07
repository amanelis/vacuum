require 'integration/integration_helper'

describe "HomeController" do
  describe "GET /" do
    it "displays default content" do
      visit root_path
      assert current_path == root_path
      page.should have_content('Vacuum')
      assert page.has_content?('Home')
      assert page.has_content?('Login')
      assert page.has_content?('Sign up')
    end
  end
end