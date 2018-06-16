class HomeworkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(course: [school: [:assignments]]).where(assignments: {user_id: user.id})
    end
  end
  def create?
    user.is_teacher_of_group?(record.group)
  end

  def update?
    user.is_teacher_of_group?(record) and record.user_id == user.id
  end

  def destroy?
    user.is_headteacher?(record.group) ||
      (user.is_teacher_of_group?(record) and record.user_id == user.id)
  end
end