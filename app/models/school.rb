class School < ApplicationRecord
  has_many :users
  has_many :courses
  has_many :groups

  has_many :students,    -> { where(role: 0) }, class_name: 'User'
  has_many :teachers,    -> { where(role: 1) }, class_name: 'User'
  has_many :moderators,  -> { where(role: 2) }, class_name: 'User'
  has_many :headmasters, -> { where(role: 3) }, class_name: 'User'
end
