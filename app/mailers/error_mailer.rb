class ErrorMailer < ActionMailer::Base
  default from: "Vacuum Error Reporting <error@vacuum.io>"
  
  def report_error(error)
    @error = error
    mail(to: error.project.user.email, subject: "Project #{error.project.name} got a new error: #{error.id}")
  end
end

class ErrorMailer < MailView
  
end
