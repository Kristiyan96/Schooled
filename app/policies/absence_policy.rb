class AbsencePolicy < ApplicationPolicy
  def show?
    user.is_headteacher?(record.course.group) ||
      user.is_teaching_course?(record.course) ||
      user == record.student ||
      user.is_parent_of?(record.student)
  end

  def create?
    user.is_headteacher?(record.schedule.course.group) ||
      user.is_headteacher?(record.schedule.course.group) ||
      user.is_teaching_course?(record.schedule.course.group) ||
      user.is_teaching_course?(record.schedule.course)
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