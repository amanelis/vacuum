class Occurrence
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters

  field :file,              type: String # Should return a url of the file containing the error caught
  field :line,              type: String # Line number the error is on and found at

  field :href,              type: String # The page the error was caught on
  field :parameters,        type: String # Any parameters that are in the url at the time
  field :language,          type: String # en-us, just language user is on
  field :platform,          type: String # MacIntel
  field :product,           type: String # Mozilla
  field :protocol,           type: String # http/https

  field :app_name,          type: String # Firefox
  field :cookie_enabled,    type: String # true/false
  field :user_agent,        type: String # Which agent use is using
  field :user_address,      type: String # User's ip address

  field :window_event,      type: String # Try and parse out the event found in error
  field :stack_trace,       type: String # For when possible

  field :browser_time,      type: String # Return the actual time recorded in browser at time of error
  field :identifier,        type: String
  
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
    return nil if self.user_agent.nil? || self.user_agent.empty?
    ['chrome', 'firefox', 'explorer', 'ie', 'netscape', 'opera', 'safari'].collect { |a| return a if self.user_agent.downcase.include?(a) }
  end
end