class Occurrence
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :app_name,        type: String
  field :user_agent,      type: String
  field :parent_url,      type: String
  field :platform,        type: String
  field :parameters,      type: String
  field :line,            type: String
  field :cookie_enabled,  type: Boolean
  field :identifier,      type: String
  
  ### Embedding
  embedded_in :error
  
  ### Callbacks
  before_create :set_identifier
end