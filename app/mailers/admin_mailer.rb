class AdminMailer < ActionMailer::Base
  default from: "Vacuum.io <reporter@vacuum.io>"
  layout 'mail'
  
  def new_user(user)
    @user  = user
    User.admin.each do |admin|
      mail(to: admin.email, subject: "Vacuum.io - New user #{user.email}")
    end
  end
end