class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :group
  belongs_to :slot
end
