module AbsencesHelper
  def format_absence(absence)
    number_with_precision(absence.try(:value), precision: 2, significant: true, strip_insignificant_zeros: true)
  end
end
