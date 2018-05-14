class Mark < ApplicationRecord
	belongs_to :student, class_name: "User", foreign_key: "user_id"
	belongs_to :course

	enum purpose: { first_term: 0, first_term_final: 1, second_term: 2, second_term_final: 3, final: 4}
end
