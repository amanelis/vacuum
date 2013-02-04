class Error
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters

  field :level,       type: String # window(means thrown by code), warn, error, debug, fatal, info
  field :message,     type: String # Unique error message, given by browser

  field :resolved,    type: Boolean # User will mark the message as true/false if its been fixed
  field :count,       type: Integer, default: 0
  field :identifier,  type: String  # Hexdecimal string to identify the error message instead of id

  ### Associations
  belongs_to :project

  ### Embedding
  embeds_many :occurrences

  ### Callbacks
  before_create :set_identifier
  after_create :send_notification
  
  def send_notification
    ErrorMailer.report_error(self).deliver
  end
end