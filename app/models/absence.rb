class Absence < ApplicationRecord
  belongs_to :schedule
  belongs_to :student, class_name: "User", foreign_key: "student_id"

  enum category: [:permanent, :excused]

  scope :student_absences_in_period, -> student, start, finish {
    joins(schedule: [:time_slot])
      .where(value: '1/1')
      .where(student_id: student.id)
      .where('time_slots.start >= ?', start)
      .where('time_slots.end <= ?', finish)
  }

  def excused?
    category == 'excused'
  end

  def permanent?
    category == 'permanent'
  end

  def self.excuse_period(student, start, finish)
    start = Date.parse(start).beginning_of_day
    finish = Date.parse(finish).end_of_day
    Absence.student_absences_in_period(student, start, finish)
      .update_all(category: 'excused')
  end
end
