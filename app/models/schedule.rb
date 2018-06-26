class Schedule < ApplicationRecord
  belongs_to :time_slot
  belongs_to :course

  has_many :absences, dependent: :destroy

  scope :courses_in_period, -> group, start, finish {
    joins(:course).joins(:time_slot)
      .where(courses: { group: group })
      .where('time_slots.start > ?', start)
      .where('time_slots.end < ?', finish)
  }

  # Interval is in days
  scope :with_start_and_end_daily, -> start, finish, interval {
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
  scope :for_week, -> date {
    for_period(date.all_week)
  }

  def self.create_with_type(params:)
    course_id, time_slot_id = params[:course_id], params[:time_slot_id]
    time_slot = TimeSlot.find(time_slot_id)

    case params[:type].to_sym
    when :one
      create(course_id: course_id, time_slot_id: time_slot_id).id
    when :series_7
      create_series(course_id, time_slot, 7).ids.first
    when :series_14
      create_series(course_id, time_slot, 14).ids.first
    else
      raise ArgumentError, "Unpermitted type."
    end
  end

  def self.create_series(course_id, time_slot, days)
    timeslots = TimeSlot.where(school_year: time_slot.school_year)
      .with_start_and_end_daily(time_slot.start, time_slot.end, days)
      .with_start_date_greater_than(time_slot.start)
      .with_end_date_before(time_slot.term_end)

    schedules = timeslots.map { |t| { time_slot_id: t.id, course_id: course_id } }
    Schedule.import(schedules)
  end

  def self.update_with_type(schedule:, params:)
    time_slot = schedule.time_slot
    course_id = params[:course_id]
    case params[:type].to_sym
    when :one
      schedule.update(course_id: course_id)
    when :series_7
      Schedule.with_start_and_end_daily(time_slot.start, time_slot.end, 7)
        .with_start_date_greater_than(time_slot.start)
        .update_all(course_id: course_id)
    when :series_14
      Schedule.with_start_and_end_daily(time_slot.start, time_slot.end, 14)
        .with_start_date_greater_than(time_slot.start)
        .update_all(course_id: course_id)
    end
  end
end
