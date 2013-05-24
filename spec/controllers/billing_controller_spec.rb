require 'spec_helper'

describe BillingController do
  include Devise::TestHelpers
  
  describe '#create' do
    let(:user) { Fabricate(:user) }
    
    context 'when not logged in' do
      subject {
        post 'create'
      }
      
      it { should_not be_nil }
      it { should be_redirect }
    end
    
    context 'when a user is logged in' do
      before {
        sign_in user
      }
      
      context 'and all valid parameters are present in the request' do
        context 'and the charge is successful' do
          let(:card_hash) { SecureRandom.hex(25)[0...20] }
          
          before {
            WebMock.allow_net_connect!
            Stripe::Customer.stub(:create).with({
              card: card_hash,
              plan: "basic_yearly_7500",
              email: user.email
            }).and_return(Stripe::Customer.all.first)
          }

          subject {
            post 'create', stripeToken: card_hash
          }

          it { should be_redirect }
        end
        
        context 'and the charge is not successful' do
          let(:card_hash) { SecureRandom.hex(25)[0...20] }

          subject {
            post 'create', stripeToken: card_hash
          }

          it { should_not be_nil }
          it { should be_redirect }
        end
      end
      
      context 'and there are missing parameters not present in the request' do
        subject {
          post 'create'
        }
        
        it { should_not be_nil }
        it { should be_redirect }
      end
    end
  end

end