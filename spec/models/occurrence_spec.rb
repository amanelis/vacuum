require 'spec_helper'

describe Occurrence do
  context "when creating a user" do
    it "has a valid fabrication" do
      Fabricate(:occurrence).should be_valid
    end
  end
  
  it { should respond_to :file }
  it { should respond_to :line }
  it { should respond_to :href }
  it { should respond_to :parameters }
  it { should respond_to :language }
  it { should respond_to :platform }
  it { should respond_to :product }
  it { should respond_to :protocol }
  it { should respond_to :app_name }
  it { should respond_to :cookie_enabled }
  it { should respond_to :user_agent }
  it { should respond_to :user_address }
  it { should respond_to :window_event }
  it { should respond_to :stack_trace }
  it { should respond_to :browser_time }
  it { should respond_to :identifier }
  it { should respond_to :created_at }
  it { should respond_to :updated_at }
end