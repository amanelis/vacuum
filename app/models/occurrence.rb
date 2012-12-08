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
  
  # human_agent
  # @param:
  # @return: String[human readable version of the User agent]
  # Tired of ready complicated user agents strings. This function
  # returns a readble version for our user to see.
  def human_agent
    ['chrome', 'firefox', 'explorer', 'ie', 'netscape', 'opera', 'safari'].collect { |a| return a if self.user_agent.downcase.include?(a) }
  end
end