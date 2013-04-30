require 'spec_helper'

describe Error do
  context "when creating an error" do
    it "has a valid fabrication" do
      user = Fabricate(:user)
      project = user.projects.build(name: Faker::Name.name, url: Faker::Internet.domain_name)
      user.save
      
      Fabricate(:error, project_id: project.id).should be_valid
    end
  end
  
  it { should respond_to :id }
  it { should respond_to :level }
  it { should respond_to :message }
  it { should respond_to :resolved }
  it { should respond_to :count }  
  it { should respond_to :identifier }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }
end