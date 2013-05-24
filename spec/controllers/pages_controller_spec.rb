require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers
  
  describe '#index' do
    context 'it should be present' do
      subject {
        get :pricing
      }
      
      it { should_not be_nil }
    end
  end
end