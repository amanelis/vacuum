class UserPreview < MailView
  def welcome_email
    UserMailer.welcome_email(User.first)
  end
end