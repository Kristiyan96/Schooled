class SchoolPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:assignments).where(assignments: {user_id: user.id, role_id: 3})
    end
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? or user.is_headmaster?(record)
  end

  def destroy?
    user.admin?
  end

  def dashboard?
    user.admin? or user.is_headmaster?(record)
  end
end