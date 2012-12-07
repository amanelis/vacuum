require 'spec_helper'

describe Error do
  context "when creating an error" do
    it "has a valid fabrication" do
      Fabricate(:error).should be_valid
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
