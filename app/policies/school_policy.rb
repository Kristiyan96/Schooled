class SchoolPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? or user.headmaster?(record)
  end

  def destroy?
    false
  end

  def dashboard?
    user.headmaster?(record)
  end
end