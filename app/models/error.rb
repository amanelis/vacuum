class Error
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  field :level,       type: String
  field :message,     type: String
  
  field :resolved,    type: Boolean
  field :count,       type: Integer, default: 0
  field :identifier,  type: String

  ### Associations
  belongs_to :project
  
  ### Embedding
  embeds_many :occurrences
  
  # Callbacks
  before_create :set_identifier
end
