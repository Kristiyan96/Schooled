class Role < ApplicationRecord
	has_many :assignments
	has_many :user, though: :assignments
end
