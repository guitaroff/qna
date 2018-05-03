class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, [Question, Answer, Comment]
      end
    else
      can :read, :all
    end
  end
end
