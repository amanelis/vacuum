class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :paid,                type: Boolean, :default => false
  field :subscribed_on,       type: Time
  field :stripe_token,        type: String
  field :stripe_customer_id,  type: String

  ### Associations
  belongs_to :user
end