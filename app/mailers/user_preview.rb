class UserPreview < MailView
  def welcome_email
    UserMailer.welcome_email(User.first)
  end
  
  def temp_password
    UserMailer.temp_password(User.first, Devise.friendly_token[0,10])
  end
end