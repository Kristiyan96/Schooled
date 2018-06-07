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
  scope :for_period, -> start, finish {
    where('start > ?', start)
      .where('end < ?', finish)
  }
  scope :for_day, -> date {
    for_period(date.beginning_of_day, date.end_of_day)
  }
  scope :for_school, -> school {
    where(school_year: school.school_years)
  }

  def self.create_week_daily(school_year:, params:)
    period_start = school_year.start
    period_end = school_year.end
    start = Time.parse(params[:start])
    finish = Time.parse(params[:end])
    title = params[:title]
    time_slots = []
    (period_start.to_i..period_end.to_i).step(1.day) do |day|
      day = Time.zone.at(day).to_date
      s = Utils.datetime_from_date_and_time(day, start)
      e = Utils.datetime_from_date_and_time(day, finish)
      time_slots << { start: s, end: e, school_year_id: school_year.id, title: title }
    end
    TimeSlot.import(time_slots)
  end

  def self.update_with_type(time_slot:, type:, params:)
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

  def self.destroy_with_type(time_slot:, type:)
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
