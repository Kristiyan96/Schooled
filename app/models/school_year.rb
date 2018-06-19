class SchoolYear < ApplicationRecord
  belongs_to :school
  has_many :courses
  has_many :time_slots

  validates_uniqueness_of :active, if: :active, scope: :school_id

  def self.create_active(params)
    year = new(params)
    where(school: year.school).update_all(active: false)
    year.save
  end

  def active_term
    midterm.past? ? 'second_semester' : 'first_semester'
  end
end
