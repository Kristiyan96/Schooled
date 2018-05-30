module SchoolsHelper
  def school_url(school)
    school_path(school.id)
  end
end
