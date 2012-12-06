class Project
  include Mongoid::Document
  include DefaultAttributeSetters
  
  field :url, type: String
  field :enabled, type: Boolean, default: true
  field :api_key, type: String
  
  field :identifier, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  ### Associations
  belongs_to :user

  ### Callbacks
  before_create :set_identifier, :set_created_at, :set_api_key
  after_update  :set_updated_at
end
