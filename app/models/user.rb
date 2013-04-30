class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include DefaultAttributeSetters
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
    :recoverable, :rememberable, :trackable, :validatable, :encryptable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :password_salt,      :type => String, :default => ""
  
  # Custom fields
  field :username, :type => String
  field :identifier, :type => String
  field :active, :type => Boolean, :default => true
  field :admin, :type => Boolean, :default => false
  field :paid, :type => Boolean, :default => false
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  ## Token authenticatable
  field :authentication_token, :type => String
  
  ### Validations
  validates :email, :presence => true
  validates :encrypted_password, :presence => true
  
  ### Associations
  has_many :projects, autosave: true, :dependent => :destroy
  
  # Callbacks
  before_save :ensure_authentication_token
  before_create :set_identifier, :set_created_at
  after_update  :set_updated_at
  
  ### Scopes
  scope :admin, where(admin: true)
  
  def create_project?
    return false if !self.paid? && self.projects.count >= 1
    return true
  end
end
