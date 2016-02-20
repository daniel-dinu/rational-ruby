require 'test/unit'

require_relative 'test_helper'

require 'rational2'


class TestRational < Test::Unit::TestCase
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @known_values = {[1, 2] => [1, 2],
                     [-1, 2] => [-1, 2],
                     [1, -2] => [-1, 2],
                     [-1, -2] => [1, 2],

                     [2, 4] => [1, 2],
                     [-2, 4] => [-1, 2],
                     [2, -4] => [-1, 2],
                     [-2, -4] => [1, 2],

                     [2, 1] => [2, 1],
                     [-2, 1] => [-2, 1],
                     [2, -1] => [-2, 1],
                     [-2, -1] => [2, 1],

                     [4, 2] => [2, 1],
                     [-4, 2] => [-2, 1],
                     [4, -2] => [-2, 1],
                     [-4, -2] => [2, 1]}
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    @known_values = nil
  end

  def test_constructor_numerator_type_error
    assert_raises(TypeError) { Rational2::Rational.new(1.2) }
  end

  def test_constructor_denominator_type_error
    assert_raises(TypeError) { Rational2::Rational.new(1, 1.2) }
  end

  def test_constructor_denominator_zero_division_error
    numerator = 1
    denominator = 0
    assert_raises(ZeroDivisionError) { Rational2::Rational.new(numerator, denominator) }

    numerator = Rational2::Rational.new
    denominator = 0
    assert_raises(ZeroDivisionError) { Rational2::Rational.new(numerator, denominator) }

    numerator = Rational2::Rational.new
    denominator = Rational2::Rational.new
    assert_raises(ZeroDivisionError) { Rational2::Rational.new(numerator, denominator) }
  end

  def test_constructor_numerator
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      assert_equal(value[0], r.numerator, "(numerator=#{key[0]}, denominator=#{key[1]})")
    end
  end

  def test_constructor_denominator
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      assert_equal(value[1], r.denominator, "(numerator=#{key[0]}, denominator=#{key[1]})")
    end
  end

  def test_constructor_transform
    test_constructor_transform_values = {
        [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1),
        [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 4)] => Rational2::Rational.new(2),
        [Rational2::Rational.new(1, 4), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 2),
        [Rational2::Rational.new(-1, 2), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-1),
        [Rational2::Rational.new(-1, 2), Rational2::Rational.new(1, 4)] => Rational2::Rational.new(-2),
        [Rational2::Rational.new(-1, 4), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-1, 2),
        [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(-1),
        [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 4)] => Rational2::Rational.new(-2),
        [Rational2::Rational.new(1, 4), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(-1, 2),
        [Rational2::Rational.new(-1, 2), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(1),
        [Rational2::Rational.new(-1, 2), Rational2::Rational.new(-1, 4)] => Rational2::Rational.new(2),
        [Rational2::Rational.new(-1, 4), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(1, 2)}

    test_constructor_transform_values.each do |key, value|
      computed_result = Rational2::Rational.new(key[0], key[1])
      message = "(numerator=#{key[0].inspect}, denominator=#{key[1].inspect}, expected_result=#{value.inspect})"
      assert_equal(value, computed_result, message)
    end
  end

  def test_transform
    test_transform_values = {[1, 2] => [1, 2],
                             [2, 4] => [2, 4],
                             [-1, 2] => [-1, 2],
                             [-2, 4] => [-2, 4],
                             [1, -2] => [1, -2],
                             [2, -4] => [2, -4],
                             [-1, -2] => [-1, -2],
                             [-2, -4] => [-2, -4],

                             [Rational2::Rational.new(1, 2), 1] => [1, 2],
                             [Rational2::Rational.new(1, 2), 2] => [1, 4],
                             [Rational2::Rational.new(-1, 2), 1] => [-1, 2],
                             [Rational2::Rational.new(-1, 2), 2] => [-1, 4],
                             [Rational2::Rational.new(1, -2), 1] => [-1, 2],
                             [Rational2::Rational.new(1, -2), 2] => [-1, 4],
                             [Rational2::Rational.new(1, 2), -1] => [1, -2],
                             [Rational2::Rational.new(1, 2), -2] => [1, -4],
                             [Rational2::Rational.new(-1, 2), -1] => [-1, -2],
                             [Rational2::Rational.new(-1, 2), -2] => [-1, -4],

                             [1, Rational2::Rational.new(1, 2)] => [2, 1],
                             [2, Rational2::Rational.new(1, 2)] => [4, 1],
                             [-1, Rational2::Rational.new(1, 2)] => [-2, 1],
                             [-2, Rational2::Rational.new(1, 2)] => [-4, 1],
                             [1, Rational2::Rational.new(-1, 2)] => [2, -1],
                             [2, Rational2::Rational.new(-1, 2)] => [4, -1],
                             [1, Rational2::Rational.new(1, -2)] => [2, -1],
                             [2, Rational2::Rational.new(1, -2)] => [4, -1],
                             [-1, Rational2::Rational.new(1, 2)] => [-2, 1],
                             [-2, Rational2::Rational.new(1, 2)] => [-4, 1],


                             [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 2)] => [2, 2],
                             [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 4)] => [4, 2],
                             [Rational2::Rational.new(1, 4), Rational2::Rational.new(1, 2)] => [2, 4],
                             [Rational2::Rational.new(-1, 2), Rational2::Rational.new(1, 2)] => [-2, 2],
                             [Rational2::Rational.new(-1, 2), Rational2::Rational.new(1, 4)] => [-4, 2],
                             [Rational2::Rational.new(-1, 4), Rational2::Rational.new(1, 2)] => [-2, 4],
                             [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => [2, -2],
                             [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 4)] => [4, -2],
                             [Rational2::Rational.new(1, 4), Rational2::Rational.new(-1, 2)] => [2, -4],
                             [Rational2::Rational.new(-1, 2), Rational2::Rational.new(-1, 2)] => [-2, -2],
                             [Rational2::Rational.new(-1, 2), Rational2::Rational.new(-1, 4)] => [-4, -2],
                             [Rational2::Rational.new(-1, 4), Rational2::Rational.new(-1, 2)] => [-2, -4]}

    test_transform_values.each do |key, value|
      computed_result = Rational2::Rational.new.transform(key[0], key[1])
      message = "(numerator=#{key[0].inspect}, denominator=#{key[1].inspect}, expected_result=#{value.inspect})"
      assert_equal(value, computed_result, message)
    end
  end

  def test_gcd
    gcd_test_values = {[0, 0] => 0,
                       [0, 1] => 1,
                       [1, 0] => 1,
                       [0, -1] => -1,
                       [-1, 0] => -1,
                       [2, 4] => 2,
                       [-2, 4] => 2,
                       [-2, -4] => -2,
                       [42, 30] => 6,
                       [42, -30] => -6,
                       [-42, -30] => -6}

    gcd_test_values.each do |key, value|
      computed_gcd = Rational2::Rational.new.gcd(key[0], key[1])
      assert_equal(value, computed_gcd, "(numerator=#{key[0]}, denominator=#{key[1]}, expected_gcd=#{value})")
    end
  end

  def test_value
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      expected_value = value[0] / (value[1] * 1.0)
      message = "(numerator=#{key[0]}, denominator=#{key[1]}, expected_result=#{expected_value})"
      assert_equal(expected_value, r.value, message)
    end
  end

  def test_quotient
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      expected_value = value[0] / value[1]
      message = "(numerator=#{key[0]}, denominator=#{key[1]}, expected_result=#{expected_value})"
      assert_equal(expected_value, r.quotient, message)
    end
  end

  def test_remainder
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      expected_value = value[0] % value[1]
      message = "(numerator=#{key[0]}, denominator=#{key[1]}, expected_result=#{expected_value})"
      assert_equal(expected_value, r.remainder, message)
    end
  end

  def test_to_s
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      if 1 == value[1]
        expected_str = "#{value[0]}"
      else
        expected_str = "#{value[0]}/#{value[1]}"
      end
      assert_equal(expected_str, r.to_s, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_inspect
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      expected_inspect = "Rational2::Rational(#{value[0]}, #{value[1]})"
      assert_equal(expected_inspect, r.inspect, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_to_f
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      expected_value = value[0] / (value[1] * 1.0)
      assert_equal(expected_value, r.to_f, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_to_i
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1])
      expected_value = value[0] / value[1]
      assert_equal(expected_value, r.to_i, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_neg
    @known_values.each do |key, value|
      r = -Rational2::Rational.new(key[0], key[1])
      assert_equal(-value[0], r.numerator, "(numerator=#{key[0]}, denominator=#{key[1]}")
      assert_equal(value[1], r.denominator, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_pos
    @known_values.each do |key, value|
      r = +Rational2::Rational.new(key[0], key[1])
      assert_equal(value[0], r.numerator, "(numerator=#{key[0]}, denominator=#{key[1]}")
      assert_equal(value[1], r.denominator, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_abs
    @known_values.each do |key, value|
      r = Rational2::Rational.new(key[0], key[1]).abs
      assert_equal(value[0].abs, r.numerator, "(numerator=#{key[0]}, denominator=#{key[1]}")
      assert_equal(value[1], r.denominator, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_invert_zero_division_error
    r = Rational2::Rational.new(0)
    assert_raises(ZeroDivisionError) { ~r }
  end

  def test_invert
    @known_values.each do |key, value|
      r = ~Rational2::Rational.new(key[0], key[1])

      if 0 > value[0]
        expected_inverted_numerator = -value[1]
        expected_inverted_denominator = -value[0]
      else
        expected_inverted_numerator = value[1]
        expected_inverted_denominator = value[0]
      end

      assert_equal(expected_inverted_numerator, r.numerator, "(numerator=#{key[0]}, denominator=#{key[1]}")
      assert_equal(expected_inverted_denominator, r.denominator, "(numerator=#{key[0]}, denominator=#{key[1]}")
    end
  end

  def test_lt
    true_test_cases = {Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                       Rational2::Rational.new => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4)}

    false_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                        Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 < r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 < r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end

  def test_le
    true_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                       Rational2::Rational.new => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4)}

    false_test_cases = {Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                        Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 <= r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 <= r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end

  def test_eq
    true_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4)}

    false_test_cases = {Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                        Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 == r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 == r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end

  def test_eqq
    true_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4)}

    false_test_cases = {Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                        Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 === r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 === r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end

  def test_leqg
    leqg_test_cases = {[Rational2::Rational.new, Rational2::Rational.new] =>0,
                       [Rational2::Rational.new(-1, 2), Rational2::Rational.new(1, -2)] => 0,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(2, 4)] => 0,
                       [Rational2::Rational.new(-1, 2), Rational2::Rational.new] => -1,
                       [Rational2::Rational.new, Rational2::Rational.new(1, 2)] => -1,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new] => 1,
                       [Rational2::Rational.new, Rational2::Rational.new(-1, 2)] => 1,
                       [Rational2::Rational.new(-1, 2), Rational2::Rational.new(1, 2)] => -1,
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(1, 2)] => -1,
                       [Rational2::Rational.new(-1, 2), Rational2::Rational.new(-1, 4)] => -1,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => 1,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 4)] => 1,
                       [Rational2::Rational.new(-1, 4), Rational2::Rational.new(-1, 2)] => 1}

    leqg_test_cases.each do |key, expected_result|
      r1 = key[0]
      r2 = key[1]
      assert_equal(expected_result, r1 <=> r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=#{expected_result}")
    end
  end


  def test_ne
    true_test_cases = {Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                       Rational2::Rational.new => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                       Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                       Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    false_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 != r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 != r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end

  def test_ge
    true_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                       Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                       Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                       Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    false_test_cases = {Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 >= r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 >= r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end

  def test_gt
    true_test_cases = {Rational2::Rational.new(1, 2) => Rational2::Rational.new,
                       Rational2::Rational.new => Rational2::Rational.new(-1, 2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(-1, 2),
                       Rational2::Rational.new(1, 2) => Rational2::Rational.new(1, 4),
                       Rational2::Rational.new(-1, 4) => Rational2::Rational.new(-1, 2)}

    false_test_cases = {Rational2::Rational.new => Rational2::Rational.new,
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new,
                        Rational2::Rational.new => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, -2),
                        Rational2::Rational.new(1, 2) => Rational2::Rational.new(2, 4),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(1, 4) => Rational2::Rational.new(1, 2),
                        Rational2::Rational.new(-1, 2) => Rational2::Rational.new(-1, 4)}

    true_test_cases.each do |r1, r2|
      assert_equal(true, r1 > r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=true")
    end

    false_test_cases.each do |r1, r2|
      assert_equal(false, r1 > r2, "(r1=#{r1.inspect}, r2=#{r2.inspect}, result=false")
    end
  end


  def test_add_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { r + 1.2 }
  end

  def test_add
    add_test_values = {[Rational2::Rational.new, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 2),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new] => Rational2::Rational.new(1, 2),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(0, 1),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(2, 4)] => Rational2::Rational.new(3, 4),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(3, 4)] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(-1, 2),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 3)] => Rational2::Rational.new(5, 6),
                       [Rational2::Rational.new(2), -1] => Rational2::Rational.new(1),
                       [Rational2::Rational.new(2), 1] => Rational2::Rational.new(3)}

    add_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 + r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_sub_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { r - 1.2 }
  end

  def test_sub
    sub_test_values = {[Rational2::Rational.new, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-1, 2),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new] => Rational2::Rational.new(1, 2),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(0, 1),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(2, 4)] => Rational2::Rational.new(-1, 4),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(3, 4)] => Rational2::Rational.new(-1, 2),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 3)] => Rational2::Rational.new(1, 6),
                       [Rational2::Rational.new(2), -1] => Rational2::Rational.new(3),
                       [Rational2::Rational.new(2), 1] => Rational2::Rational.new(1)}

    sub_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 - r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_mul_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { r * 1.2 }
  end

  def test_mul
    mul_test_values = {[Rational2::Rational.new, Rational2::Rational.new(1, 2)] => Rational2::Rational.new,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new] => Rational2::Rational.new,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 4),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(-1, 4),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(2, 4)] => Rational2::Rational.new(1, 8),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(3, 4)] => Rational2::Rational.new(3, 16),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(-3, 16),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 3)] => Rational2::Rational.new(1, 6),
                       [Rational2::Rational.new(2), 1] => Rational2::Rational.new(2),
                       [Rational2::Rational.new(2), -1] => Rational2::Rational.new(-2)}

    mul_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 * r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_div_zero_division_error
    r1 = Rational2::Rational.new(1, 2)
    r2 = Rational2::Rational.new
    assert_raises(ZeroDivisionError) { r1 / r2 }
  end

  def test_div_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { r / 1.2 }
  end

  def test_div
    div_test_values = {[Rational2::Rational.new, Rational2::Rational.new(1, 2)] => Rational2::Rational.new,
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(-1, 1),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(2, 4)] => Rational2::Rational.new(1, 2),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(3, 4)] => Rational2::Rational.new(1, 3),
                       [Rational2::Rational.new(1, 4), Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(-1, 3),
                       [Rational2::Rational.new(1, 2), Rational2::Rational.new(1, 3)] => Rational2::Rational.new(3, 2),
                       [Rational2::Rational.new(2), 1] => Rational2::Rational.new(2),
                       [Rational2::Rational.new(2), -1] => Rational2::Rational.new(-2)}

    div_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 / r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_pow_zero_division_error
    r = Rational2::Rational.new
    (-3...0).step(1) do |power|
      assert_raises(ZeroDivisionError) { r ** power }
    end
  end

  def test_pow_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { r ** 1.2 }
  end

  def test_pow
    pow_test_values = {[Rational2::Rational.new, 0] => Rational2::Rational.new,
                       [Rational2::Rational.new, 1] => Rational2::Rational.new,
                       [Rational2::Rational.new, 2] => Rational2::Rational.new,
                       [Rational2::Rational.new, 3] => Rational2::Rational.new,

                       [Rational2::Rational.new(1, 2), -3] => Rational2::Rational.new(8, 1),
                       [Rational2::Rational.new(1, 2), -2] => Rational2::Rational.new(4, 1),
                       [Rational2::Rational.new(1, 2), -1] => Rational2::Rational.new(2, 1),
                       [Rational2::Rational.new(1, 2), 0] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 2), 1] => Rational2::Rational.new(1, 2),
                       [Rational2::Rational.new(1, 2), 2] => Rational2::Rational.new(1, 4),
                       [Rational2::Rational.new(1, 2), 3] => Rational2::Rational.new(1, 8),

                       [Rational2::Rational.new(-1, 2), -3] => Rational2::Rational.new(-8, 1),
                       [Rational2::Rational.new(-1, 2), -2] => Rational2::Rational.new(4, 1),
                       [Rational2::Rational.new(-1, 2), -1] => Rational2::Rational.new(-2, 1),
                       [Rational2::Rational.new(-1, 2), 0] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(-1, 2), 1] => Rational2::Rational.new(-1, 2),
                       [Rational2::Rational.new(-1, 2), 2] => Rational2::Rational.new(1, 4),
                       [Rational2::Rational.new(-1, 2), 3] => Rational2::Rational.new(-1, 8),

                       [Rational2::Rational.new(1, 3), -3] => Rational2::Rational.new(27, 1),
                       [Rational2::Rational.new(1, 3), -2] => Rational2::Rational.new(9, 1),
                       [Rational2::Rational.new(1, 3), -1] => Rational2::Rational.new(3, 1),
                       [Rational2::Rational.new(1, 3), 0] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(1, 3), 1] => Rational2::Rational.new(1, 3),
                       [Rational2::Rational.new(1, 3), 2] => Rational2::Rational.new(1, 9),
                       [Rational2::Rational.new(1, 3), 3] => Rational2::Rational.new(1, 27),

                       [Rational2::Rational.new(-1, 3), -3] => Rational2::Rational.new(-27, 1),
                       [Rational2::Rational.new(-1, 3), -2] => Rational2::Rational.new(9, 1),
                       [Rational2::Rational.new(-1, 3), -1] => Rational2::Rational.new(-3, 1),
                       [Rational2::Rational.new(-1, 3), 0] => Rational2::Rational.new(1, 1),
                       [Rational2::Rational.new(-1, 3), 1] => Rational2::Rational.new(-1, 3),
                       [Rational2::Rational.new(-1, 3), 2] => Rational2::Rational.new(1, 9),
                       [Rational2::Rational.new(-1, 3), 3] => Rational2::Rational.new(-1, 27)}

    pow_test_values.each do |key, expected_r|
      r1 = key[0]
      power = key[1]
      r = r1 ** power
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, power=#{power}, expected_r=#{expected_r.inspect}")
    end
  end


  def test_radd_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { 1.2 + r }
  end

  def test_radd
    radd_test_values = {[1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(3, 2),
                        [1, Rational2::Rational.new] => Rational2::Rational.new(1, 1),
                        [-1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-1, 2),
                        [1, Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(1, 2),
                        [1, Rational2::Rational.new(2, 4)] => Rational2::Rational.new(3, 2),
                        [1, Rational2::Rational.new(3, 4)] => Rational2::Rational.new(7, 4),
                        [1, Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(1, 4),
                        [1, Rational2::Rational.new(1, 3)] => Rational2::Rational.new(4, 3)}

    radd_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 + r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_rsub_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { 1.2 - r }
  end

  def test_rsub
    rsub_test_values = {[1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 2),
                        [1, Rational2::Rational.new()] => Rational2::Rational.new(1, 1),
                        [-1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-3, 2),
                        [1, Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(3, 2),
                        [1, Rational2::Rational.new(2, 4)] => Rational2::Rational.new(1, 2),
                        [1, Rational2::Rational.new(3, 4)] => Rational2::Rational.new(1, 4),
                        [1, Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(7, 4),
                        [1, Rational2::Rational.new(1, 3)] => Rational2::Rational.new(2, 3)}

    rsub_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 - r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_rmul_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { 1.2 * r }
  end

  def test_rmul
    rmul_test_values = {[1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(1, 2),
                        [1, Rational2::Rational.new()] => Rational2::Rational.new(0, 1),
                        [-1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-1, 2),
                        [1, Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(-1, 2),
                        [1, Rational2::Rational.new(2, 4)] => Rational2::Rational.new(1, 2),
                        [1, Rational2::Rational.new(3, 4)] => Rational2::Rational.new(3, 4),
                        [1, Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(-3, 4),
                        [1, Rational2::Rational.new(1, 3)] => Rational2::Rational.new(1, 3)}

    rmul_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 * r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end

  def test_rdiv_type_error
    r = Rational2::Rational.new
    assert_raises(TypeError) { 1 / r }
    assert_raises(TypeError) { 1.2 / r }
  end

  def test_rdiv
    rdiv_test_values = {[1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(2, 1),
                        [-1, Rational2::Rational.new(1, 2)] => Rational2::Rational.new(-2, 1),
                        [1, Rational2::Rational.new(-1, 2)] => Rational2::Rational.new(-2, 1),
                        [1, Rational2::Rational.new(2, 4)] => Rational2::Rational.new(2, 1),
                        [1, Rational2::Rational.new(3, 4)] => Rational2::Rational.new(4, 3),
                        [1, Rational2::Rational.new(-3, 4)] => Rational2::Rational.new(-4, 3),
                        [1, Rational2::Rational.new(1, 3)] => Rational2::Rational.new(3, 1)}

    rdiv_test_values.each do |key, expected_r|
      r1 = key[0]
      r2 = key[1]
      r = r1 / r2
      assert_equal(expected_r, r, "(r1=#{r1.inspect}, r2=#{r2.inspect}, expected_r=#{expected_r.inspect}")
    end
  end
end
