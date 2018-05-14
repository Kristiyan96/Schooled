class Subject < ApplicationRecord
  belongs_to :school

  has_many :marks
end
