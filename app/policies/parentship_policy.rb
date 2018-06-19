class ParentshipPolicy < ApplicationPolicy
  def create?
    user == record
  end
end