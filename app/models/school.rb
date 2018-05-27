class School < ApplicationRecord

  has_many :subjects
  has_many :school_years
  has_many :groups
  has_many :courses
end
