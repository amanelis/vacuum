require 'spec_helper'

describe Error do
  context "when creating an error" do
    it "has a valid fabrication" do
      Fabricate(:error).should be_valid
    end
  end
end
