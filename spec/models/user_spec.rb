require 'spec_helper'

describe User do
  context "when creating a user" do
    it "has a valid fabrication" do
      Fabricate(:user).should be_valid
    end
  end
  
  context "when creating an admin" do
    it "has a valid fabrication" do
      user = Fabricate(:user, admin: true)
      assert(user.admin == true)
    end
  end
  
  it { should respond_to :id }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :encrypted_password }
  
  it { should respond_to :username }
  it { should respond_to :identifier }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }
  it { should respond_to :authentication_token }
  it { should respond_to :admin }
  it { should respond_to :active }
end