class CoursePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def show? 
    user.admin? ||
      user.headmaster?(record.school) ||
      user.teaching_course?(record)
  end

  def create?
    user.admin? ||
      user.headmaster?(record.school) ||
      user.headteacher?(record.group)
  end

  def update?
    user.admin? ||
      user.headmaster?(record.school) ||
      user.headteacher?(record.group) ||
      user.teaching_course?(record)
  end

  def destroy?
    user.admin? ||
      user.headmaster?(record.school)
  end
end