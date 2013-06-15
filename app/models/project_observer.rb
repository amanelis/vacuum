class ProjectObserver < Mongoid::Observer
  observe :project
  
  def before_create(project)
    project.identifier = SecureRandom.hex(25)[0...20] if project.identifier.nil?
    project.api_key    = SecureRandom.hex(25)[0...40] if project.api_key.nil?
  end
  
  def after_create(project)
    project.notifications.build(name: "Owner (#{project.user.email})", email: project.user.email) unless project.try(:user).nil?
  end
end
