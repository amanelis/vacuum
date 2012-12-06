require 'integration/integration_helper'


describe 'devise/registration#create' do
  it "signs up a new user" do
    email = Faker::Internet.email
    
    visit '/signup'
    fill_in "user_email",     :with => email
    fill_in "user_password",  :with => 'password123'
    fill_in "user_password_confirmation", :with => 'password123'
    click_button 'Sign up'
          
    assert current_path == root_path
    expect(page).to have_content("Vacuum")
  end
  
  it "does not sign up a new user if passwords do not match" do
    email = Faker::Internet.email
    
    visit '/signup'
    fill_in "user_email",     :with => email
    fill_in "user_password",  :with => 'password123'
    fill_in "user_password_confirmation", :with => 'password'
    click_button 'Sign up'
          
    assert current_path == root_path
    expect(page).to have_content("Password doesn't match confirmation")
  end
  
  it "does not sign up a new user if the user already exists" do
    user = User.create!(email: Faker::Internet.email, password: 'password123')
    
    visit '/signup'
    fill_in "user_email", :with => user.email
    click_button 'Sign up'
    
    assert current_path == root_path
    expect(page).to have_content("Email has already been taken")
  end
end

describe 'devise/sessions#create' do
  it "signs in a signed up user" do
    user = User.create!(email: Faker::Internet.email, password: 'password123')
    
    visit '/login'
    fill_in "user_email",     :with => user.email
    fill_in "user_password",  :with => 'password123'
    click_button 'Sign in'
    
    assert current_path == root_path
    expect(page).to have_content("Vacuum")
  end
end
