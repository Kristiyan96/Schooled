class School < ApplicationRecord
  has_many :subjects
  has_many :school_years
  has_many :groups
  has_many :courses
  has_many :assignments
  has_many :users, through: :assignments
  has_many :roles, through: :assignments

  def teachers
    users.joins(:assignments, :roles).where(roles: { name: "Teacher" })
  end

  def students
    users.joins(:assignments, :roles).where(roles: { name: "Student" })
  end

  def active_school_year
    school_years.where(active: true).first
  end
end
