class AdminPreview < MailView
  def new_user
    AdminMailer.new_user(User.last)
  end
end