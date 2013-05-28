class Ability
  include CanCan::Ability

  def initialize(user)
    # Define a user
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      ### Projects ###
      can [:create], Project if user.create_project?
      
      can [:read], Project do |project|
        project.user_id == user.id || project.collaborators.collect { |c| c.user_id == user.id }.any?
      end

      can [:destroy, :update], Project do |project|
        project.user_id == user.id
      end

      ### Errors ###
      can [:create, :resolve], Error do |error|
        error.project.user_id == user.id
      end

      can [:read], Error do |error|
        error.project.user_id == user.id || error.project.collaborators.collect { |c| c.user_id == user.id }.any?
      end
    end
  end
end