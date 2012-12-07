class Occurrence
  include Mongoid::Document
  include DefaultAttributeSetters
  
  field :browser, type: String
  field :message, type: String
  embedded_in :error
  
  # Callbacks
  before_create :set_identifier, :set_created_at
  after_update  :set_updated_at
end