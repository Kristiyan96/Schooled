class AbsencePolicy < ApplicationPolicy

  def create?
    user.admin? ||
      user.headmaster?(record.schedule.course.school) ||
      user.headteacher?(record.schedule.course.group) ||
      user.teaching_course?(record.schedule.course)
  end

  def update?
    update?
  end

  def destroy?
    create?
  end
end