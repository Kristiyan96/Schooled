class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.present?
      if user.admin?
        can :manage, :all
      end
    end
  end
end
