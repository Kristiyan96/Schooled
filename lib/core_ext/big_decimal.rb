# frozen_string_literal: true

class BigDecimal
  def formatted
    i = to_i
    f = to_f
    i == f ? i : f
  end
end
