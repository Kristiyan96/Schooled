class School < ApplicationRecord
  has_many :students
  has_many :teachers
  has_many :headmasters

  has_many :subjects
  has_many :school_years
end
