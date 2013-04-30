class Ability
  include CanCan::Ability

  def initialize(user)
    # Define a user
    user ||= User.new
    
    if user.admin?
      can :manage, :all
    else      
      ### Projects ###
      can :create, Project unless user.create_project?
      can [:read, :update, :destroy], Project do |project|
        project.user_id == user.id || project.collaborators.collect { |c| BSON::ObjectId(c.user_id).to_s == user.id.to_s }.any?
      end  
      
      ### Errors ###
      can :create, Error do |error|
        error.project.user_id = user.id
      end
      
      can [:read], Error do |error|
        error.project.user_id == user.id || error.project.collaborators.collect { |c| BSON::ObjectId(c.user_id).to_s == user.id.to_s }.any?
      end
      
      can [:resolve, :destroy], Error do |error|
        error.project.user_id == user.id
      end
    end
  end
end