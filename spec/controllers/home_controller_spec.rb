require 'spec_helper'

describe HomeController do
  include Devise::TestHelpers
  
  describe '#index' do
    context 'it should be present' do
      subject {
        get :index
      }
      
      it { should_not be_nil }
    end
  end
end