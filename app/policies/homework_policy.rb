class HomeworkPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.joins(course: [school: [:assignments]]).where(assignments: {user_id: user.id})
    end
  end

  def create?
    user.teaching_course?(record.course)
  end

  def update?
    user.teaching_course?(record.course) or user.headteacher?(record.group)
  end

  def destroy?
    user.teaching_course?(record.course) or user.headteacher?(record.group)
  end
end