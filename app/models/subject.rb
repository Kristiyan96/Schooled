class Subject < ApplicationRecord
  belongs_to :school, optional: true
  has_many :courses
end
