class Collaborator
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :email, type: String
  field :user_id, type: String
  field :identifier, type: String
  
  ### Associations
  belongs_to :project
  
  ### Validations
  validates :email, :presence => true
end