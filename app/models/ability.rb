class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can :manage, :all
    elsif user.author?
      can :crud, [ Model, Component, Experiment, Diag, Figure ]
    else
      can :read, :all
    end
  end
end
