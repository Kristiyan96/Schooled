class UserPolicy < ApplicationPolicy

  def show?
    true
  end

  def schedule?
    user == record
  end
end