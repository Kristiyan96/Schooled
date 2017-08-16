class User < ApplicationRecord
  belongs_to :school, optional: true
  belongs_to :group,  optional: true
  belongs_to :parent, class_name: 'User',
                      foreign_key: 'parent_id',
                      optional: true

  has_many :marks
  has_many :children, class_name: 'User', foreign_key: 'parent_id'

  enum role: { student: 0, teacher: 1, moderator: 2, headmaster: 3 }

  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password,
            presence: true,
            length: { minimum: 6 },
            allow_blank: true
  validates :password_digest, presence: true, allow_blank: true

  def admin?
    admin
  end
end
