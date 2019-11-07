# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    return unless user
    user.admin? ? admin_abilities : user_abilities
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    can :read, :all
    can :create, Website
    can :parse, Page
  end
end
