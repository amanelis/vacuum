class Collaborator
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :user_id, type: String
  field :email, type: String
  field :identifier, type: String
  
  ### Embedded documents
  embedded_in :project
end