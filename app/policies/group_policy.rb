class GroupPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.joins(school: [:assignments]).where(assignments: {user_id: user.id, role_id: 3})
    end
  end

  def show?
    user.headmaster?(record.school) ||
      user.headteacher?(record) ||
      user.teacher_of_group?(record) ||
      user.student_in_group?(record) ||
      user.parent_in_group?(record)
  end

  def create?
    user.headmaster?(record.school)
  end

  def update?
    user.headmaster?(record.school) or user.headteacher?(record)
  end

  def destroy?
    user.admin? or user.headmaster?(record.school)
  end

  def teacher?
    user.teacher_of_group?(record) ||
      user.headteacher?(record) || 
      user.headmaster?(record.school)
  end

  def week_schedule?
    user.headmaster?(record.school) ||
      user.headteacher?(record) ||
      user.teacher_of_group?(record) ||
      user.student_in_group?(record) ||
      user.parent_in_group?(record)
  end

  def day_schedule?
    user.headmaster?(record.school) or user.headteacher?(record)
  end

  def marks?
    user.headmaster?(record.school) or user.headteacher?(record)
  end
end