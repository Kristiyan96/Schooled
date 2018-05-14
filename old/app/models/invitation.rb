class Invitation < ApplicationRecord
  belongs_to :student, foreign_key: 'user_id', class_name: 'User'
  belongs_to :group
end
