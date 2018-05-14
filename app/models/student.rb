class Student < ApplicationRecord
  belongs_to :school
  belongs_to :classroom

  has_many :marks
  has_many :remarks

  has_many :guardianships
  has_many :parents, through: :guardianships, foreign_key: "student_id", class_name: "Guardianship"

  has_many :messages, as: :recepient
  has_many :messages, as: :sender
end
