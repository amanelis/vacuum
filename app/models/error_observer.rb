class ErrorObserver < Mongoid::Observer
  
  # Before the object is created, set the identifier
  def before_create(error)
    error.identifier = SecureRandom.hex(25)[0...20] if error.try(:identifier).nil?
  end
    
  # After an error is created, notifiy the project owner
  # TODO(amanelis): will want to check email subscribe permissions
  #   before blasting off emails
  def after_create(error)
    return false if error.project.nil?
    return false if error.project.user.nil?
    
    ErrorMailer.report_error(error).deliver
  end
end