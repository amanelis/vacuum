class ErrorMailer < ActionMailer::Base
  default from: "Vacuum.io <support@vacuum.io>"
  layout 'mail'
  
  def report_error(error, notifier)
    @error = error
    @email = notifier.email
    mail(to: @email, subject: "New [#{@error.level}] error for #{@error.project.name}")
  end
end
