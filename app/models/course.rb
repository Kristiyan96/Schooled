class Course < ApplicationRecord
  belongs_to :group
  belongs_to :subject
  belongs_to :school
  belongs_to :school_year
  belongs_to :teacher, foreign_key: "teacher_id", class_name: "User"

  has_many :schedules
  has_many :time_slots, through: :schedules

  scope :in_year, -> (group_id, year) { Course.joins(:school_year).where(school_years: {year: year}, courses: {group_id: group_id}) }
  scope :ordered, -> { joins(:subject).order("subjects.name") }

  def name
    subject.name
  end

  def year
    school_year.year
  end

  class None
    def self.name
      "Празен"
    end

    def self.id
      nil
    end
  end
end
