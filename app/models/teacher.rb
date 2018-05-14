class Teacher < ApplicationRecord
  include Authentication

  belongs_to :school

  has_many :classrooms

  has_many :messages, as: :recepient
  has_many :messages, as: :sender
end
