class Role < ApplicationRecord
	has_many :assignments
	has_many :users, though: :assignments
end
