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
  field :username,    :type => String
  field :identifier,  :type => String
  field :active,      :type => Boolean, :default => true
  field :admin,       :type => Boolean, :default => false
  
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
  field :unconfirmed_email,    :type => String 

  ## Lockable
  field :failed_attempts, :type => Integer, :default => 0 
  field :unlock_token,    :type => String 
  field :locked_at,       :type => Time
  
  ## Email
  field :sent_welcome_email,  :type => Boolean, :default => false
  field :subscribed,          :type => Boolean, :default => true

  ## Token authenticatable
  field :authentication_token, :type => String
  
  ### Validations
  validates :email,               :presence => true, :uniqueness => true
  validates :encrypted_password,  :presence => true
  
  ### Associations
  has_many :projects, autosave: true, :dependent => :destroy
  has_one  :subscription, autosave: true, :dependent => :destroy
  
  ### Scopes
  scope :admin,       where(admin: true)
  scope :subscribed,  where(subscribed: true)
  
  # create_project?
  # Method for authorization to create more projects. User must be paying to do this.
  def create_project?
    return true if self.admin? # admin always true
    
    # False if they have not paid and they have added at least one project
    return false if self.subscription.nil? && self.projects.count >= 1
    return true
  end
  
  # needs_to_pay?
  # If the admin is present or user has paid, payment is not required.
  def needs_to_pay?
    return false if self.admin? # admin always true
    
    # 30 days, really needs to pay
    return true if self.subscription.nil? && 14.days.ago > self.created_at 
    
    # False if they need to pay their bill
    return true if self.subscription.nil?
    return false
  end
end