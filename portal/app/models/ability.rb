# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.e_admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
