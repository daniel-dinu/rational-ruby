require 'rational2/version'


module Rational2
  begin
    class Rational
      NUMERATOR_TYPE_ERROR_MESSAGE = 'The numerator of a rational must be a rational or an integer value!'
      DENOMINATOR_TYPE_ERROR_MESSAGE = 'The denominator of a rational must be a rational or an integer value!'

      DENOMINATOR_ZERO_DIVISION_ERROR_MESSAGE = 'The denominator of a rational number can not be zero!'

      DIVIDER_ZERO_DIVISION_ERROR_MESSAGE = 'The divider cannot be 0!'

      POWER_TYPE_ERROR_MESSAGE = 'The power must be an integer value!'

      ZERO_TO_NEGATIVE_POWER_ZERO_DIVISION_ERROR_MESSAGE = '0 cannot be raised to a negative power!'

      SECOND_TERM_TYPE_ERROR_MESSAGE = 'The second term must be a rational or an integer value!'


      attr_reader :numerator, :denominator


      def initialize(numerator = 0, denominator = 1)
        unless numerator.is_a? Integer or numerator.is_a? Rational2::Rational
          raise(TypeError, NUMERATOR_TYPE_ERROR_MESSAGE)
        end

        unless denominator.is_a? Integer or denominator.is_a? Rational2::Rational
          raise(TypeError, DENOMINATOR_TYPE_ERROR_MESSAGE)
        end

        if denominator.is_a? Integer and 0 == denominator
          raise(ZeroDivisionError, DENOMINATOR_ZERO_DIVISION_ERROR_MESSAGE)
        end

        if denominator.is_a? Rational2::Rational and 0 == denominator.numerator
          raise(ZeroDivisionError, DENOMINATOR_ZERO_DIVISION_ERROR_MESSAGE)
        end

        if numerator.is_a? Rational2::Rational or denominator.is_a? Rational2::Rational
          numerator, denominator = transform(numerator, denominator)
        end

        divisor = gcd(numerator, denominator)

        @numerator = numerator / divisor
        @denominator = denominator / divisor
      end

      def gcd(a, b)
        while 0 != b do
          r = a % b
          a = b
          b = r
        end
        a
      end

      def transform(a, b)
        if a.is_a? Rational2::Rational
          numerator = a.numerator
          denominator = a.denominator
        else
          numerator = a
          denominator = 1
        end

        if b.is_a? Rational2::Rational
          numerator *= b.denominator
          denominator *= b.numerator
        else
          denominator *= b
        end

        return numerator, denominator
      end

      def value
        @numerator / (@denominator * 1.0)
      end

      def quotient
        @numerator / @denominator
      end

      def remainder
        @numerator % @denominator
      end

      def to_s
        if 1 == @denominator
          "#{numerator}"
        else
          "#{@numerator}/#{@denominator}"
        end
      end

      def inspect
        "#{self.class}(#{@numerator}, #{@denominator})"
      end

      def to_f
        @numerator / (@denominator * 1.0)
      end

      def to_i
        @numerator / @denominator
      end

      def -@
        Rational2::Rational.new(-@numerator, @denominator)
      end

      def +@
        Rational2::Rational.new(@numerator, @denominator)
      end

      def abs
        Rational2::Rational.new(@numerator.abs, @denominator)
      end

      def ~
        Rational2::Rational.new(@denominator, @numerator)
      end

      def <(other)
        @numerator * other.denominator < @denominator * other.numerator
      end

      def <=(other)
        @numerator * other.denominator <= @denominator * other.numerator
      end

      def ==(other)
        @numerator * other.denominator == @denominator * other.numerator
      end

      def ===(other)
        @numerator * other.denominator == @denominator * other.numerator
      end

      def <=>(other)
        if @numerator * other.denominator < @denominator * other.numerator
          -1
        elsif @numerator * other.denominator > @denominator * other.numerator
          1
        else
          0
        end
      end

      def !=(other)
        @numerator * other.denominator != @denominator * other.numerator
      end

      def >=(other)
        @numerator * other.denominator >= @denominator * other.numerator
      end

      def >(other)
        @numerator * other.denominator > @denominator * other.numerator
      end

      def +(other)
        unless other.is_a? Rational2::Rational or other.is_a? Integer
          raise(TypeError, SECOND_TERM_TYPE_ERROR_MESSAGE)
        end

        if other.is_a? Integer
          other = Rational2::Rational.new(other)
        end

        numerator = @numerator * other.denominator + @denominator * other.numerator
        denominator = @denominator * other.denominator

        Rational2::Rational.new(numerator, denominator)
      end

      def -(other)
        unless other.is_a? Rational2::Rational or other.is_a? Integer
          raise(TypeError, SECOND_TERM_TYPE_ERROR_MESSAGE)
        end

        if other.is_a? Integer
          other = Rational2::Rational.new(other)
        end

        numerator = @numerator * other.denominator - @denominator * other.numerator
        denominator = @denominator * other.denominator

        Rational2::Rational.new(numerator, denominator)
      end

      def *(other)
        unless other.is_a? Rational2::Rational or other.is_a? Integer
          raise(TypeError, SECOND_TERM_TYPE_ERROR_MESSAGE)
        end

        if other.is_a? Integer
          other = Rational2::Rational.new(other)
        end

        numerator = @numerator * other.numerator
        denominator = @denominator * other.denominator

        Rational2::Rational.new(numerator, denominator)
      end

      def /(other)
        unless other.is_a? Rational2::Rational or other.is_a? Integer
          raise(TypeError, SECOND_TERM_TYPE_ERROR_MESSAGE)
        end

        if other.is_a? Integer
          other = Rational2::Rational.new(other)
        end

        if 0 == other.numerator
          raise(ZeroDivisionError, DIVIDER_ZERO_DIVISION_ERROR_MESSAGE)
        end

        numerator = @numerator * other.denominator
        denominator = @denominator * other.numerator

        Rational2::Rational.new(numerator, denominator)
      end

      def **(power)
        unless power.is_a? Integer
          raise(TypeError, POWER_TYPE_ERROR_MESSAGE)
        end

        if 0 > power and 0 == @numerator
          raise(ZeroDivisionError, ZERO_TO_NEGATIVE_POWER_ZERO_DIVISION_ERROR_MESSAGE)
        end

        if 0 == power and 0 == @numerator
          return Rational2::Rational.new(@numerator, @denominator)
        end

        if 0 > power
          numerator = @denominator ** -power
          denominator = @numerator ** -power
        else
          numerator = @numerator ** power
          denominator = @denominator ** power
        end

        Rational2::Rational.new(numerator, denominator)
      end

      def coerce(other)
        other = Rational2::Rational.new(other)
        if caller[0] =~ /`-'/
          [-self, -other]
        elsif caller[0] =~ /`\/'/
          [~self, ~other]
        else
          [self, other]
        end
      end

    end
  end
end
