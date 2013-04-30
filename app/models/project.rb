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
  has_many :notifications, autosave: true, :dependent => :destroy
  has_many :errors, autosave: true, :dependent => :destroy
  belongs_to :user
  
  ### Embedded documents
  embeds_many :collaborators

  ### Validations
  validates :name, :presence => true
  validates :url,  :presence => true

  ### Callbacks
  before_create :set_identifier, :set_api_key

  def to_js
    host = Rails.env.development? || Rails.env.test? ? '//localhost:3000' : '//vacuum.io'
    script = "<script type=\"text/javascript\">" + 
      "var _vacuum = _vacuum || []; " +
      "_vacuum.push(['_setKey', '"+self.api_key+"']);" +
      "_vacuum.push(['_setIdentifier', '"+self.identifier+"']);" +
      "_vacuum.push(['debug', false]);" +
      "</script>" +
      "<script src=\"#{host}/vacuum.js\"></script>"
    return script
  end
end