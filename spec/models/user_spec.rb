require 'spec_helper'

describe User do 
  context 'when creating a user' do
    it 'has a valid fabrication' do
      Fabricate(:user).should be_valid
    end
  end 
  
  describe 'associations' do
    it { should have_many(:projects).with_autosave }
  end
  
  describe 'attributes' do
    it { should respond_to :id }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
    it { should respond_to :encrypted_password }
    it { should respond_to :username }
    it { should respond_to :identifier }
    it { should respond_to :authentication_token }
    it { should respond_to :admin }
    it { should respond_to :active }
    it { should respond_to :authentication_token }
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
  end
  
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :encrypted_password }
  end
  
  describe '.admin' do
    before {
      @user = Fabricate(:user)
      @admin = Fabricate(:user, admin: true)
    }

    context 'it includes users with the admin attribute set to true' do
      subject {
        User.admin.to_a.include?(@admin) 
      }

      it { should be_true }
      it { should_not be_nil }
    end

    context 'it does not include users with the admin attribute set to false' do
      subject {
        User.admin.to_a.include?(@user) 
      }

      it { should be_false }
      it { should_not be_nil }
    end
  end

  describe '#send_welcome_email' do
    pending "BUILD THIS FEATURE"
  end
end