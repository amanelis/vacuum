class Notification
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters

  field :name,              type: String
  field :email,             type: String
  field :identifier,        type: String
  
  ### Associations
  belongs_to :project

  ### Callbacks
  before_create :set_identifier
end
