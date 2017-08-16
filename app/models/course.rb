class Course < ApplicationRecord
  belongs_to :school
  belongs_to :subject

  has_one :student_class
end
