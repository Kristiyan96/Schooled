class MarkPolicy < ApplicationPolicy

  def create?
    user.admin? ||
      user.headmaster?(record.course.school) ||
      user.headteacher?(record.course.group) ||
      user.teaching_course?(record.course)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end