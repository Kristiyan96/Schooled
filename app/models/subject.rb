class Subject < ApplicationRecord
  belongs_to :school, optional: true
end
