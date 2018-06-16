class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(school: [:assignments]).where(assignments: {user_id: user.id, role_id: 3})
    end
  end

  def show?
    user.is_headmaster?(record.school) ||
      user.is_headteacher?(record) ||
      user.is_teacher_of_group?(record) ||
      user.is_student_in_group?(record) ||
      user.is_parent_in_group?(record)
  end

  def create?
    user.is_headmaster?(record.school)
  end

  def update?
    user.is_headmaster?(record) or user.is_headteacher?(record)
  end

  def destroy?
    user.admin?
  end

  def teacher?
    user.is_teacher_of_group?(record) ||
      user.is_headteacher?(record) || 
      user.is_headmaster?(record.school)
  end
end