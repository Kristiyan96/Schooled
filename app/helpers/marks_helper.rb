module MarksHelper
  def formatted_mark(mark)
    mark.grade == mark.grade.floor ? '%g' % mark.grade : ('%.2f' % mark.grade)
  end
end
