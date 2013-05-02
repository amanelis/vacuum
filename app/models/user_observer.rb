class UserObserver < Mongoid::Observer
  observe :user
  
  def before_create(user)
    user.identifier = SecureRandom.hex(25)[0...20] if user.identifier.nil?
  end
  
  def after_create(user)
    # Send welcome email
    UserMailer.delay.welcome_email(user) unless user.sent_welcome_email?
    
    # Notify the admins of new user
    AdminMailer.delay.new_user(user)

    # Create/Save authentication token 
    user.reset_authentication_token! if user.authentication_token.nil?
  end
end