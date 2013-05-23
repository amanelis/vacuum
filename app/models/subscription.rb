class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :paid,           type: Boolean, :default => false
  field :paid_on,        type: Time
  field :amount_charged, type: String
  field :stripe_token,   type: String

  ### Associations
  belongs_to :user
end