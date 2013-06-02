class UserMailer < ActionMailer::Base
  default from: "Vacuum.io <support@vacuum.io>"
  layout 'mail'
  
  def welcome_email(user)
    @user = user 
    mail(:to => @user.email, :subject => "Welcome to Vacuum.io")
    user.update_attributes!(sent_welcome_email: true)
  end
  
  def temp_password(user, password)
    @user = user
    @password = password
    mail(:to => @user.email, :subject => "New temporary password for Vacuum.io")
  end
end
