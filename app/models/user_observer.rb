class UserObserver < Mongoid::Observer
  observe :user
  
  def after_create(user)
    # Send welcome email
    UserMailer.delay.welcome_email(user) unless user.sent_welcome_email?

    # Ensure that the authentication token
    # is present and saved 
    user.reset_authentication_token! if user.authentication_token.nil?

    # Lets set the identifier for the user
    user.update_attributes!(identifier: SecureRandom.hex(25)[0...20]) if user.identifier.nil?
  end
end