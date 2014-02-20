class ErrorObserver < Mongoid::Observer
  observe :error
  
  def before_create(error)
    error.identifier = SecureRandom.hex(25)[0...20] if error.identifier.nil?
  end

  def after_create(error)
    return false if error.nil?
    return false if error.project.nil?
    return false if error.project.user.nil?
    
    error.project.notifications.each { |notifier| 
      next if notifier.nil?
      ErrorMailer.delay.report_error(error, notifier) 
    }
  end
end
