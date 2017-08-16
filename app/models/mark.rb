class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum purpose: { normal: 0, first_term: 1, second_term: 2, final: 3 }
end
