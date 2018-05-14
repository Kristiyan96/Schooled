class Course < ApplicationRecord
  belongs_to :subject
  belongs_to :school
  belongs_to :teacher, class_name: "User", foreign_key: "user_id"
  belongs_to :group

  has_many :messages, as: :entity
  has_many :lessons

  def name
    subject.name
  end

  def abbreviation
    subject.abbreviation
  end

  def name_class
    "#{abbreviation} #{group.grade}#{group.name}"
  end
end
