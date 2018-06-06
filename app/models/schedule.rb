class Schedule < ApplicationRecord
  belongs_to :time_slot
  belongs_to :course

  scope :with_courses_for_period, -> group, start, finish {
    joins(:course).joins(:time_slot)
      .where(courses: { group: group })
      .where('time_slots.start > ?', start)
      .where('time_slots.end < ?', finish)
  }
end
