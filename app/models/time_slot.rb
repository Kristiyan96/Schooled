class TimeSlot < ApplicationRecord
  belongs_to :school_year
  has_one :school, through: :school_year

  has_many :schedules
  has_many :courses, through: :schedules

  scope :with_interval_from_start_and_end, -> start, finish, interval {
    where("DATE_PART('hour', time_slots.start) = ?", start.hour)
      .where("DATE_PART('minute', time_slots.start) = ?", start.min)
      .where("DATE_PART('hour', time_slots.end) = ?", finish.hour)
      .where("DATE_PART('minute', time_slots.end) = ?", finish.min)
      .where("CAST(DATE_PART('day', time_slots.start - ?) AS INTEGER) % ? = 0", start, interval)
  }
  scope :with_start_date_greater_than, -> date {
    where('time_slots.start >= ?', date)
  }
  scope :for_period, -> period {
    where(start: period)
      .where(end: period)
  }
  scope :for_day, -> date {
    for_period(date.all_day)
  }
  scope :for_week, -> date {
    for_period(date.all_week)
  }
  scope :this_week, -> { for_week(Time.current) }
  scope :for_work_week, -> date {
    week = date.to_datetime.all_week
    a, b = week.first, week.last - 2.days
    for_period(a..b)
  }
  scope :for_work_week_with_saturday, -> date {
    week = date.to_datetime.all_week
    a, b = week.first, week.last - 1.days
    for_period(a..b)
  }
  scope :for_school, -> school {
    where(school_year: school.school_years)
  }
  scope :group_schedule, -> group {
    sql = sanitize_sql_array([<<~SQL, group_id: group.id])
    LEFT OUTER JOIN schedules ON schedules.time_slot_id = time_slots.id AND schedules.id IN
      (SELECT schedules.id FROM schedules WHERE schedules.course_id IN
        (SELECT courses.id FROM courses WHERE courses.group_id = :group_id)
      )
    SQL
    joins(sql).eager_load(:schedules)
  }
  scope :group_schedule_for_week, -> group {
    group_schedule(group).this_week
  }
  default_scope { order('start ASC') }

  def self.create_week_daily(school_year:, date:, params:)
    period_start = date.to_datetime.beginning_of_day
    period_end   = school_year.end
    start        = Time.parse(params[:start])
    finish       = Time.parse(params[:end])
    title        = params[:title]
    time_slots   = []
    (period_start.to_i..period_end.to_i).step(1.day) do |day|
      day = Time.zone.at(day).to_date
      s   = Utils.datetime_from_date_and_time(day, start)
      e   = Utils.datetime_from_date_and_time(day, finish)
      time_slots << { start: s, end: e, school_year_id: school_year.id, title: title }
    end
    TimeSlot.import(time_slots)
  end

  def self.update_with_type(time_slot:, type:, params:)
    s, e = params[:start], params[:end]
    day  = time_slot.start.to_date
    s    = Utils.datetime_from_date_and_time(day, Time.zone.parse(s))
    e    = Utils.datetime_from_date_and_time(day, Time.zone.parse(e))
    case type.to_sym
    when :one
      time_slot.update(params)
    when :all
      sql = sanitize_sql_for_assignment([<<~SQL.split("\n").join(" "), start: s, end: e, title: params[:title]])
          start = date_trunc('day', start) +
          date_part('hour', TIMESTAMP :start) * interval '1 hour' +
          date_part('minute', TIMESTAMP :start) * interval '1 minute' +
          date_part('second', TIMESTAMP :start) * interval '1 second',
          "end" = date_trunc('day', "end") +
          date_part('hour', TIMESTAMP :end) * interval '1 hour' +
          date_part('minute', TIMESTAMP :end) * interval '1 minute' +
          date_part('second', TIMESTAMP :end) * interval '1 second',
          title = :title
        SQL
      year = time_slot.school_year
      TimeSlot.with_interval_from_start_and_end(time_slot.start, year.end, 1)
        .with_start_date_greater_than(time_slot.start)
        .update_all(sql)
    end
  end

  def self.destroy_with_type(time_slot:, type:)
    case type.to_sym
    when :one
      time_slot.destroy
    when :all
      year = time_slot.school_year
      TimeSlot.with_interval_from_start_and_end(time_slot.start, year.end, 1)
        .with_start_date_greater_than(time_slot.start)
        .destroy_all
    end
  end

  def self.schedule_table_for_group(group, day = Time.current)
    time_slots_by_day = group_schedule(group).for_work_week_with_saturday(day)
      .map { |t| [t, t.schedules] }
      .group_by { |(t, _)| t.start.strftime("%A") }

    if time_slots_by_day['Saturday'].all? { |(t, ss)| ss.empty? }
      time_slots_by_day.delete('Saturday')
    end

    max = time_slots_by_day.values.map do |ts|
      ts
        .map.with_index { |t, i| [t, i] }
        .max_by { |((t, s), index)| s.empty? ? 0 : index }
    end.max[1]


    time_slots_by_day.map { |day, data| [day, data[0..max]] }.to_h
  end

  def self.convert_to_time(t)
    Time.zone.parse(t)
  end
end
