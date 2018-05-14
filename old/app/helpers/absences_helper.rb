module AbsencesHelper
  def validate_absence(absence)
    absence = absence.ceil if absence%1>=0.98
    absence = 0 if absence < 0 
    absence
  end
end
