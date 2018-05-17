class Classroom < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :school_year

  has_many :students
end
