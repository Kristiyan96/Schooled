module SchoolYearsHelper
  def current_year(school)
    school.school_years.order(:year).last
  end
end
