class Collaborator
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :email, type: String
  field :identifier, type: String
  
  ### Associations
  belongs_to :project
  belongs_to :user
  
  ### Validations
  validates :email, :presence => true
end