class Course < ApplicationRecord
  belongs_to :group
  belongs_to :subject
  belongs_to :school
  belongs_to :school_year
  belongs_to :teacher, foreign_key: "teacher_id", class_name: "User"

  has_many :marks, dependent: :destroy
  has_many :remarks, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :absences, through: :schedules
  has_many :time_slots, through: :schedules

  scope :in_year, -> (group_id, year) { Course.joins(:school_year).where(school_years: {year: year}, courses: {group_id: group_id}) }

  def name
    subject.name
  end

  def year
    school_year.year
  end

  def self.ordered_by_subject
     includes(:subject).order('subjects.name DESC')
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
