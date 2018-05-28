class School < ApplicationRecord
  has_many :subjects
  has_many :school_years
  has_many :groups
  has_many :courses
  has_many :users, through: :assignments

  def teachers
    users.find_each.select { |u| u.role? :teacher}
  end

  def students
    users.find_each.select { |u| u.role? :student}
  end
end
