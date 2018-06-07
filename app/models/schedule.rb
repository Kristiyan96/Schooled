class Schedule < ApplicationRecord
  belongs_to :time_slot
  belongs_to :course

  scope :courses_in_period, -> group, start, finish {
    joins(:course).joins(:time_slot)
      .where(courses: { group: group })
      .where('time_slots.start > ?', start)
      .where('time_slots.end < ?', finish)
  }

  # Interval is in days
  scope :with_interval_from_start_and_end, -> start, finish, interval {
    joins(:time_slot)
      .where("CAST(DATE_PART('day', time_slots.start - ?) as INTEGER) % ? = 0", start, interval)
      .where("CAST(DATE_PART('day', time_slots.end - ?) as INTEGER) % ? = 0", finish, interval)
  }
  scope :with_start_date_greater_than, -> date {
    joins(:time_slot)
      .where('time_slots.start >= ?', date)
  }

  def self.create_with_type(school:, course_id:, time_slot_id:, type:)
    raise ArgumentError unless type.in?([:one, :series_7, :series_14])
    time_slot = TimeSlot.find(time_slot_id)

    case type
    when :one
      create(course_id: course_id, time_slot_id: time_slot_id)
    when :series_7
      create_series(school, course_id, time_slot, 7.days)
    when :series_14
      create_series(school, course_id, time_slot, 14.days)
    end
  end

  def self.create_series(school, course_id, time_slot, days)
    timeslots = TimeSlot.where(school_year: time_slot.school_year)
      .with_interval_from_start_and_end(time_slot.start, time_slot.end, days)

    schedules = timeslots.map { |t| { time_slot_id: t.id, course_id: course_id, school_year: time_slot.school_year } }
    Schedule.import(schedules)
  end

  def self.update_with_type(school:, schedule:, type:, course_id:)
    time_slot = schedule.time_slot
    case type
    when :one
      schedule.update(course_id: course_id)
    when :series_7
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 7.days)
        .with_start_date_greater_than(time_slot.start)
        .update_all(course_id: course_id)
    when :series_14
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 14.days)
        .with_start_date_greater_than(time_slot.start)
        .update_all(course_id: course_id)
    end
  end

  def self.destroy_with_type(school:, schedule:, type:)
    time_slot = schedule.time_slot

    case type
    when :one
      schedule.destroy
    when :series_7
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 7.days)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    when :series_14
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 14.days)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    end
  end
end
