class Parent < ApplicationRecord
  has_many :guardianships
  has_many :children, through: :guardianships, foreign_key: "parent_id"

  has_many :messages, as: :recepient
  has_many :messages, as: :sender
end
