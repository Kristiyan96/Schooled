class School < ApplicationRecord
  has_many :subjects
  has_many :school_years
  has_many :groups
  has_many :courses
  has_many :assignments
  has_many :users, through: :assignments
  has_many :roles, through: :assignments

  def teachers
    users.joins(:assignments, :roles).find_each.select { |u| u.role?(:teacher, self)}
  end

  def students
    users.find_each.select { |u| u.role?(:student,self)}
  end
end
