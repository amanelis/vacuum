class Error
  include Mongoid::Document
  include DefaultAttributeSetters
  
  field :level, type: String
  field :message, type: String
  field :resolved, type: Boolean
  field :count, type: Integer, default: 0
  
  field :identifier, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  ### Associations
  belongs_to :project
  
  ### Embedding
  embeds_many :occurrences
  
  # Callbacks
  before_create :set_identifier, :set_created_at
  after_update  :set_updated_at
end
