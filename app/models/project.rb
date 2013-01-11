class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters

  field :name, type: String
  field :url, type: String
  field :enabled, type: Boolean, default: true
  field :api_key, type: String

  field :identifier, type: String

  ### Associations
  has_many :errors, autosave: true, :dependent => :destroy
  belongs_to :user

  ### Validations
  validates :name, :presence => true
  validates :url,  :presence => true

  ### Callbacks
  before_create :set_identifier, :set_api_key

  def to_js
    case Rails.env
    when "development" || "test"
      host = "http://localhost:3000"
    when "production"
      host = "http://vacuumhq.herokuapp.com"
      # host = "http://s3.amazonaws.com/vacuum"
    end

    javascript = "<script type=\"text/javascript\" src=\"#{host}/vacuum.js\"></script>" +
                 "<script type=\"text/javascript\">" +
                   "try {" +
                      "vacuum.api_key = '" + self.api_key + "';" +
                      "vacuum.window_error = true;" +
                      "console.log(vacuum.status());" +
                   "} catch(e) {}" +
                 "</script>"
    javascript
  end
end
