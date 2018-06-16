class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    record == user or
      user.is_headmaster?(record.group&.school) or
      user.is_headteacher?(record.group)
  end

  def add_parent?
    record == user ||
      user.is_headmaster?(record.group&.school) ||
      user.is_headteacher?(record.group) ||
      user.is_parent_of?(record)
  end

  def schedule?
    user == record
  end
end