class UserPolicy < ApplicationPolicy

  def show?
    true
  end

  def invite_parent?
    user == record ||
      user.parent_of?(record) ||
      user.headteacher?(record.group)
  end

  def schedule?
    user == record
  end
end