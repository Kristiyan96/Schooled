class Assignment < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :school

  def name
    "#{role.name} at #{school.name}"
  end
end
