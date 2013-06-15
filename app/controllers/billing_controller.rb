class BillingController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    if params[:stripeToken].nil? || params[:stripeToken].empty?
      flash[:error] = "There was a problem with your card, please try again."
      redirect_to root_path
      return false
    end
    
    # Create a subscription if they don't have one
    current_user.create_subscription if current_user.subscription.nil?

    begin 
      card_info = {
        card: params[:stripeToken],
        plan: "basic_yearly_7500",
        email: current_user.email
      }
      
      # Sign a customer up to our plan.
      customer = Stripe::Customer.create(card_info)
    rescue => e
      flash[:error] = "There was an error charging your card. #{e}"
      redirect_to root_path
      return false
    end
    
    if customer.try(:id).nil?
      flash[:error] = "There was an error saving your subscription."
      redirect_to root_path
      return false
    end

    # Update a few attributes
    current_user.subscription.update_attributes!(paid: true, subscribed_on: Time.now, stripe_token: params[:stripeToken], stripe_customer_id: customer.id)
    
    flash[:success] = "Thanks! We charged your card and you are good to go."
    redirect_to root_path
  end
end