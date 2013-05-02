class UserMailer < ActionMailer::Base
  default from: "Vacuum.io <reporter@vacuum.io>"
  layout 'mail'
  
  def welcome_email(user)
    @user = user 
    mail(:to => @user.email, :subject => "Welcome to Vacuum.io")
    user.update_attributes!(sent_welcome_email: true)
  end
end
