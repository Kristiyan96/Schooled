class Teacher < ApplicationRecord
  include Authentication

  belongs_to :school, optional: true

  has_many :classrooms

  has_many :messages, as: :recepient
  has_many :messages, as: :sender

  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
end
