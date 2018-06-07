class SchoolYear < ApplicationRecord
  belongs_to :school
  has_many :courses

  validates_uniqueness_of :active, if: :active, scope: :school_id
end
