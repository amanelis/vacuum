class Occurrence
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters

  field :file,                type: String # Should return a url of the file containing the error caught
  field :line,                type: String # Line number the error is on and found at
  
  field :app_code_name,       type: String
  field :app_name,            type: String
  field :app_version,         type: String
  field :browser_time,        type: String
  field :browser_time_zone,   type: String
  field :charset,             type: String
  field :cookie_enabled,      type: String
  field :cookies,             type: String
  field :href,                type: String
  field :host,                type: String
  field :hostname,            type: String
  field :java_enabled,        type: String
  field :language,            type: String
  field :origin,              type: String
  field :pathname,            type: String
  field :parameters,          type: String
  field :platform,            type: String
  field :port,                type: String
  field :product,             type: String
  field :protocol,            type: String
  field :referrer,            type: String
  field :remote_addr,         type: String
  field :screen_height,       type: String
  field :screen_width,        type: String
  field :stack_trace,         type: String
  field :url,                 type: String
  field :user_agent,          type: String
  field :vendor,              type: String
  field :window_event,        type: String
  field :identifier,          type: String
  
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
    ['chrome', 'firefox', 'explorer', 'ie', 'netscape', 'opera', 'safari', 'iphone'].collect { |a| 
      return a if self.user_agent.downcase.include?(a) 
    }.try(:uniq).try(:first)
  end
end