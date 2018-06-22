class Rational

  def humanize
    if denominator == 1
      numerator.to_s
    else
      Rational(numerator, denominator).to_s
    end
  end
end