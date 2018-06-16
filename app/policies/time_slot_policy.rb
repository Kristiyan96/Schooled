class TimeSlotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(school_year: [school: [:assignments]]).where(assignments: {user_id: user.id, role_id: 3})
    end
  end

  def show?
    true
  end

  def create?
    user.is_headmaster?(record.school_year.school)
  end

  def update?
    user.is_headmaster?(record.school_year.school)
  end

  def destroy?
    user.is_headmaster?(record.school_year.school)
  end
end