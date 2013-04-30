class ErrorPreview < MailView
  def report_error
    ErrorMailer.report_error(Error.first)
  end
end