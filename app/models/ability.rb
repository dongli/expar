class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :update, :destroy => :update_and_destroy

    if user.admin?
      can :manage, :all
    elsif user.author?
      can :read, all
      can :create, Experiment
      can :update_and_destroy, Experiment, :user_id => user.id
    else
      can :read, :all
    end
  end
end
