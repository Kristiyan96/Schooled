module MarksHelper

  def mark_color(mark)
    if mark.grade<2.5
      "danger"
    elsif mark.grade<3.5
      "warning"
    elsif mark.grade<4.5
      "primary"
    elsif mark.grade<5.5
      "info"
    else
      "success" 
    end
  end
  
  def formatted_mark(mark)
    mark.grade == mark.grade.floor ? '%g' % mark.grade : ('%.2f' % mark.grade)
  end

  def average_mark_until_now_weekly_this_semester(student)
    periods = weeks_until_now_this_semester(student.group.school)
    start = periods.first.beginning_of_day
    averages = []

    periods.each do |p|
      averages << (Mark
        .where('student_id=? AND created_at>? AND created_at<?', student.id, start, p.end_of_day)
        .average(:grade) || 0)
    end

    averages
  end
end
