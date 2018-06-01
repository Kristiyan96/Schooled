module SchoolsHelper
  def school_url(school)
    school_path(school.id)
  end

  def school_name(school)
    "#{school.name if school.name} #{'-' if school.number && school.name} #{school.number if school.number}"
  end
end
