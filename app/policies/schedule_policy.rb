class ScedulePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(course: [school: [:assignments]]).where(assignments: {user_id: user.id})
    end
  end

  def show?
    user.is_headmaster?(record.school) || 
      user.is_headteacher?(record) || 
      user.is_student_in_group?(record)
  end

  def create?
    user.is_headmaster?(record.school) || user.is_headteacher?(record)
  end

  def update?
    user.is_headmaster?(record.school) || user.is_headteacher?(record)
  end

  def destroy?
    user.is_headmaster?(record.school) || user.is_headteacher?(record)
  end
end