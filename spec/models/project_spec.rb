require 'spec_helper'

describe Project do
  context "when creating a user" do
    it "has a valid fabrication" do
      Fabricate(:project).should be_valid
    end
  end
  
  describe 'associations' do
    it { should have_many :errors }
    it { should belong_to :user }
  end
  
  describe 'attributes' do
    it { should respond_to :id }
    it { should respond_to :name }
    it { should respond_to :url }
    it { should respond_to :enabled }
    it { should respond_to :api_key }
    it { should respond_to :identifier }
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :url }
  end
end
