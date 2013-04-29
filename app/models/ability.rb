class Ability
  include CanCan::Ability

  def initialize(user)
    # Define a user
    user ||= User.new
    
    if user.admin?
      can :manage, :all
    else
      # Starting with the highest level and cascading down
      # the document tree
      
      ##################
      #### PROJECTS ####
      ##################
      can :create, Project
      can [:read, :update, :cancel, :destroy], Project do |project|
        project.user_id == user.id
      end
      
      
    end
  end
end
