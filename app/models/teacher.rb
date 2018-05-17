class Teacher < ApplicationRecord
  include Authentication

  belongs_to :school, optional: true

  has_many :classrooms

  has_many :messages, as: :recepient
  has_many :messages, as: :sender
end
