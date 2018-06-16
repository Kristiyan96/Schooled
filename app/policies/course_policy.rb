class CousePolicy < ApplicationPolicy
  def show? 
    user.admin? ||
      user.is_headmaster?(record.school) ||
      user.is_teaching_course?(record)
  end

  def create?
    user.admin? ||
      user.is_headmaster?(record.school)
  end

  def update?
    user.admin? ||
      user.is_headmaster?(record.school) ||
      user.is_teaching_course?(record)
  end

  def destroy?
    user.admin? ||
      user.is_headmaster?(record.school)
  end
end