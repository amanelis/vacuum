class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters

  field :name,        type: String
  field :url,         type: String
  field :enabled,     type: Boolean, default: true
  field :api_key,     type: String
  field :identifier,  type: String

  ### Associations
  belongs_to :user
  has_many :errors, autosave: true, :dependent => :destroy
  has_many :collaborators, autosave: true, :dependent => :destroy
  has_many :notifications, autosave: true, :dependent => :destroy

  ### Validations
  validates :name, :presence => true, :uniqueness => { :scope => :user_id }
  validates :url,  :presence => true, :uniqueness => { :scope => :user_id }

  def to_js
    # host = Rails.env.development? || Rails.env.test? ? 'localhost:3000' : 'vacuum.io'
    script = "<script type=\"text/javascript\">" +
      "var _vacuum = _vacuum || []; " +
      "_vacuum.push(['_setKey', '"+self.api_key+"']);" +
      "_vacuum.push(['_setIdentifier', '"+self.identifier+"']);" +
      "_vacuum.push(['debug', false]);" +
      "(function() {" +
        "var vs = document.createElement('script'); vs.type = 'text/javascript'; vs.async = true;" +
        "vs.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + '#{SETTINGS[:cloudfront_alias]}/vacuum.js';" +
        "var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(vs, s);" +
      "})();" +
      "</script>"
    return script
  end
end