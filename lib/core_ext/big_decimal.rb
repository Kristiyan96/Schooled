class BigDecimal
  def formatted
    i, f = self.to_i, self.to_f
    i == f ? i : f
  end
end