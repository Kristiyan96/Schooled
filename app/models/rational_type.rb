class RationalType < ActiveRecord::Type::Value
  def cast(input)
    Rational(input)
  end

  def serialize(rational)
    rational.to_s
  end
end
