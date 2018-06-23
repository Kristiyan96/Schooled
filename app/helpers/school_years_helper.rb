module SchoolYearsHelper
  def current_year(school)
    school.school_years.order(:year).last
  end

  def weeks_until_now_this_semester(school)
    school_year = school.active_school_year
    active_semester = school_year.midterm.past? ? 2 : 1

    date_start = active_semester == 1 ? school_year.start : school_year.midterm
    date_end   = active_semester == 1 ? school_year.midterm : school_year.end
    
    date_start = date_start.beginning_of_week.to_date
    date_end   = date_end.to_date

    date_start.step(date_end, 7)
  end
end
