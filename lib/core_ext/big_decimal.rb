class BigDecimal
  def format_absence
    i, f = self.to_i, self.to_f
    i == f ? i : f
  end
end