class SchoolYear < ApplicationRecord
  has_many :marks
  has_many :remarks
end
