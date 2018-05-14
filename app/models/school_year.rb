class SchoolYear < ApplicationRecord
  belongs_to :school

  has_many :marks
  has_many :remarks
end
