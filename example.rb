require 'rational2'


r = Rational2::Rational.new(1, 2)
puts("Object:      #{r.inspect}")
puts("Numerator:   #{r.numerator}")
puts("Denominator: #{r.denominator}")
puts("Value:       #{r.value}")
puts("Quotient:    #{r.quotient}")
puts("Remainder:   #{r.remainder}")

puts


a = Rational2::Rational.new(1, 2)
b = Rational2::Rational.new(a)
c = 0

puts("Initial: a = #{a}; b = #{b}")
a += 1
b = 2 - b
puts("Final:   a = #{a}; b = #{b}")

puts

puts("Initial: a = #{a}; b = #{b}")
a = r / b
b = a * r
puts("Final:   a = #{a}; b = #{b}")

puts

puts("Initial: a = #{a}; c = #{c}")
a **= 2
c = 2 ** b.value
puts("Final:   a = #{a}; c = #{c}")

puts

d = Rational2::Rational.new(a - b)
puts("Initial:                #{d}")
puts("Absolute value:         #{d.abs}")
puts("Additive inverse:       #{-d}")
puts("Multiplicative inverse: #{~d}")

puts("\n")

s = 0
(1...10).step(1) do |i|
  s += Rational2::Rational.new(1, i)
end
puts("s = #{s} = #{s.value}")

p = 1
(1...10).step(1) do |i|
  p *= Rational2::Rational.new(1, i)
end
puts("p = #{p} = #{p.value}")

puts

puts("#{s.inspect} <  #{p.inspect} : #{s < p}")
puts("#{s.inspect} <= #{p.inspect} : #{s <= p}")
puts("#{s.inspect} == #{p.inspect} : #{s == p}")
puts("#{s.inspect} != #{p.inspect} : #{s != p}")
puts("#{s.inspect} >= #{p.inspect} : #{s >= p}")
puts("#{s.inspect} >  #{p.inspect} : #{s > p}")
