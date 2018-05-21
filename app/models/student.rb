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

  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  validates :number, inclusion: { in: [1..40] }

  def courses
  	group.courses
  end
end
