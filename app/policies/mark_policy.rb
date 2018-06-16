class MarkPolicy < ApplicationPolicy
  def create?
    user.is_headteacher?(record.course.group) ||
      user.is_teaching_course?(record.course)
  end

  def update?
    user.is_headteacher?(record.course.group) ||
      user.is_teaching_course?(record.course)
  end

  def destroy?
    user.is_headteacher?(record.course.group) ||
      user.is_teaching_course?(record.course)
  end
end