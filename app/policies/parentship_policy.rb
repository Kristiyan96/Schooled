class ScedulePolicy < ApplicationPolicy

  def create?
    user == record
  end
end