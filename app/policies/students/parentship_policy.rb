class ParentshipPolicy < ApplicationPolicy
  def create?
    user.admin? ||
      user.is_headmaster?(record.student.group.school) ||
      user.is_headteacher?(record.student.group) ||

  end
end