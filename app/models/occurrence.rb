class Occurrence
  include Mongoid::Document
  include DefaultAttributeSetters
  
  field :app_name, type: String
  field :user_agent, type: String
  field :parent_url, type: String
  field :platform, type: String
  field :parameters, type: String
  field :cookie_enabled, type: Boolean
  
  field :identifier, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
  
  ### Embedding
  embedded_in :error
  
  ### Callbacks
  before_create :set_identifier, :set_created_at
  after_update  :set_updated_at
end