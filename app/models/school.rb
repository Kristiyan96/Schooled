class School < ApplicationRecord
  has_many :subjects
  has_many :school_years
  has_many :groups
  has_many :courses
  has_many :assignments
  has_many :users, through: :assignments

  def teachers
    users.distinct.joins(:assignments).where(assignments: {role_id: 2})
  end

  def students
    users.distinct.joins(:assignments, :roles).where(roles: { name: "Student" })
  end

  def active_school_year
    school_years.where(active: true).first
  end
end
