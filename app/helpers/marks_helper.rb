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
end
