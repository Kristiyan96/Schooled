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

  def toggle_category?
    user.admin? ||
      user.headteacher?(record.schedule.course.group) ||
      user.headmaster?(record.schedule.course.group.school)
  end
end