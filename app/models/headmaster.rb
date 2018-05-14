class Headmaster < ApplicationRecord
  include Authentication

  belongs_to :school

  has_many :messages, as: :recepient
  has_many :messages, as: :sender
end
