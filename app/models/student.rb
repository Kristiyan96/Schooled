class Student < ApplicationRecord
  include Authentication

  belongs_to :school
  belongs_to :group

  has_many :marks
  has_many :remarks

  has_many :guardianships
  has_many :parents, through: :guardianships, foreign_key: "student_id", class_name: "Guardianship"

  has_many :messages, as: :recepient
  has_many :messages, as: :sender

  def courses
  	group.courses
  end
end
