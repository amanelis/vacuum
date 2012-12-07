require 'integration/integration_helper'

describe 'UsersController' do
  describe 'user/registration#create' do
    it "signs up a new user" do
      email = Faker::Internet.email
    
      visit '/signup'
      fill_in "user_email",                 :with => email
      fill_in "user_password",              :with => 'password123'
      fill_in "user_password_confirmation", :with => 'password123'
      click_button 'Sign up'
          
      assert current_path == root_path
      expect(page).to have_content("Vacuum")
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  
    it "does not sign up a new user if passwords do not match" do
      email = Faker::Internet.email
    
      visit '/signup'
      fill_in "user_email",                 :with => email
      fill_in "user_password",              :with => 'password123'
      fill_in "user_password_confirmation", :with => 'password'
      click_button 'Sign up'
          
      assert current_path == user_registration_path
      expect(page).to have_content("Password doesn't match confirmation")
    end
  
    it "does not sign up a new user if the user already exists" do
      user = Fabricate(:user, password: 'password123', password_confirmation: 'password123')
    
      visit '/signup'
      fill_in "user_email",                 :with => user.email
      fill_in "user_password",              :with => 'password123'
      fill_in "user_password_confirmation", :with => 'password123'
      click_button 'Sign up'
    
      assert current_path == user_registration_path
      expect(page).to have_content("Email is already taken")
    end
  end

  describe 'user/sessions#create' do
    it "signs in a signed up user" do
      user = Fabricate(:user, password: 'password123', password_confirmation: 'password123')
    
      visit '/login'
      fill_in "user_email",     :with => user.email
      fill_in "user_password",  :with => 'password123'
      click_button 'Sign in'
    
      assert current_path == new_project_path
      expect(page).to have_content("Vacuum")
      expect(page).to have_content("Logout")
    end
  end
end
