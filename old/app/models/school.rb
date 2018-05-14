class School < ApplicationRecord
  has_many :users
  has_many :courses
  has_many :groups
  has_many :messages, as: :entity
  has_many :slots
end
