class Mark < ApplicationRecord
  belongs_to :student
  belongs_to :subject
  belongs_to :school_year
end
