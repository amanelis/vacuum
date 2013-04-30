class ErrorMailer < ActionMailer::Base
  default from: "Vacuum.io <reporter@vacuum.io>"
  layout 'mail'
  
  def report_error(error)
    @error = error
    mail(to: error.project.user.email, subject: "New [#{@error.level}] error for #{@error.project.name}")
  end
end
