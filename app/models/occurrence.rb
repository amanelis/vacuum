class Occurrence
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters


  field :url,             type: String # file:///Users/arm/Development/Rails/tmp/index.html
  field :parent_url,      type: String # file:///Users/arm/Development/Rails/tmp/index.html
  field :line,            type: String # 17
  field :user_agent,      type: String # Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11
  field :app_name,        type: String # Netscape
  field :platform,        type: String # MacIntel
  field :parameters,      type: String # ?api_key=helokey
  field :cookie_enabled,  type: String # true/false
  field :identifier,      type: String # 20318jh30114thgsdlkj3
  field :stack_trace,     type: String

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