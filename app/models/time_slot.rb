class TimeSlot < ApplicationRecord
  belongs_to :school_year

  has_many :schedules
  has_many :courses, through: :schedules

  scope :with_interval_from_start_and_end, -> start, finish, interval {
    where("CAST(DATE_PART('day', time_slots.start - ?) as INTEGER) % ? = 0", start, interval)
     .where("CAST(DATE_PART('day', time_slots.end - ?) as INTEGER) % ? = 0", finish, interval)
  }
  scope :with_start_date_greater_than, -> date {
    where('time_slots.start >= ?', date)
  }

  def self.create_week_daily(school_year_id:, start:, finish:)
    school_year = SchoolYear.find(school_year_id)
    period_start = school_year.start
    period_end = school_year.end

    time_slots = []
    (period_start.to_i..period_end.to_i).step(1.day) do |day|
      day = Time.at(day)
      s = Utils.datetime_from_date_and_time(day, start)
      e = Utils.datetime_from_date_and_time(day, finish)
      time_slots << { start: s, end: e, school_year_id: school_year_id }
    end
    TimeSlot.create(time_slots)
  end

  def self.update_with_type(time_slot:, type:, params:) do
    case type
    when :one
      time_slot.update(params)
    when :all
      year = time_slot.school_year
      TimeSlot.with_interval_from_start_and_end(year.start, year.end, 1.day)
        .with_start_date_greater_than(time_slot.start)
        .update_all(params)
    end
  end

  def self.destroy_with_type(time_slot:, type:) do
    case type
    when :one
      time_slot.destroy
    when :all
      year = time_slot.school_year
      TimeSlot.with_interval_from_start_and_end(year.start, year.end, 1.day)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    end
  end
  end
end
