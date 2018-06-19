class SubjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(school: [:assignments]).where(assignments: {user_id: user.id, role_id: 3})
    end
  end

  def create?
    user.admin? or user.is_headmaster?(record.school)
  end

  def update?
    user.admin? or user.is_headmaster?(record.school)
  end

  def destroy?
    user.admin? or user.is_headmaster?(record.school)
  end
end