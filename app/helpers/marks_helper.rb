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
end
