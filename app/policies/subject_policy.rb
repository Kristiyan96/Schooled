class SubjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(school: [:assignments]).where(assignments: {user_id: user.id, role_id: 3})
    end
  end

  def create?
    user.is_headmaster?(record.school)
  end

  def update?
    user.is_headmaster?(record)
  end

  def destroy?
    user.admin?
  end
end