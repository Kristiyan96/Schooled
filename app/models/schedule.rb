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
      .where("DATE_PART('hour', time_slots.start) = ?", start.hour)
      .where("DATE_PART('minute', time_slots.start) = ?", start.min)
      .where("DATE_PART('hour', time_slots.end) = ?", finish.hour)
      .where("DATE_PART('minute', time_slots.end) = ?", finish.min)
      .where("CAST(DATE_PART('day', time_slots.start - ?) AS INTEGER) % ? = 0", start, interval)
  }

  scope :with_start_date_greater_than, -> date {
    joins(:time_slot)
      .where('time_slots.start >= ?', date)
  }

  scope :for_period, -> period {
    joins(:time_slot).where(time_slots: {start: period})
      .where(time_slots: {end: period})
  }
  scope :for_day, -> date {
    for_period(date.all_day)
  }

  def self.create_with_type(school:, params:)
    course_id, time_slot_id = params[:course_id], params[:time_slot_id]
    time_slot = TimeSlot.find(time_slot_id)

    case params[:type].to_sym
    when :one
      create(course_id: course_id, time_slot_id: time_slot_id)
    when :series_7
      create_series(school, course_id, time_slot, 7.days)
    when :series_14
      create_series(school, course_id, time_slot, 14.days)
    else
      raise ArgumentError, "Unpermitted type."
    end
  end

  def self.create_series(school, course_id, time_slot, days)
    timeslots = TimeSlot.where(school_year: time_slot.school_year)
      .with_interval_from_start_and_end(time_slot.start, time_slot.end, days)

    schedules = timeslots.map { |t| { time_slot_id: t.id, course_id: course_id } }
    Schedule.import(schedules)
  end

  def self.update_with_type(school:, schedule:, params:)
    time_slot = schedule.time_slot
    course_id = params[:course_id]
    case params[:type].to_sym
    when :one
      schedule.update(course_id: course_id)
    when :series_7
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 7)
        .with_start_date_greater_than(time_slot.start)
        .update_all(course_id: course_id)
    when :series_14
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 14)
        .with_start_date_greater_than(time_slot.start)
        .update_all(course_id: course_id)
    end
  end

  def self.destroy_with_type(school:, schedule:, type:)
    time_slot = schedule.time_slot

    case type.to_sym
    when :one
      schedule.destroy
    when :series_7
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 7)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    when :series_14
      Schedule.with_interval_from_start_and_end(time_slot.start, time_slot.end, 14)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    end
  end
end
