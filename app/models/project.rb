class Project
  include Mongoid::Document
  include DefaultAttributeSetters
  
  field :name, type: String
  field :url, type: String
  field :enabled, type: Boolean, default: true
  field :api_key, type: String
  
  field :identifier, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  ### Associations
  has_many :errors, autosave: true, :dependent => :destroy
  belongs_to :user

  ### Validations
  validates :name, :presence => true
  validates :url,  :presence => true

  ### Callbacks
  before_create :set_identifier, :set_created_at, :set_api_key
  after_update  :set_updated_at
  
  def to_js
    javascript = "<script type=\"text/javascript\" src=\"http://localhost:3000/vacuum.js\"></script>" +
                 "<script type=\"text/javascript\">" + 
                   "try {" +
                      "vacuum.api_key = '" + self.api_key + "';" +
                      "vacuum.window_error = false;" +
                      "console.log(vacuum.status());" +
                   "} catch(err) {}" +
                 "</script>"
    javascript   
  end
end
