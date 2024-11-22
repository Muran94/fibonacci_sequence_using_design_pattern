# frozen_string_literal: true

class FibonacciSequence
  private attr_reader :fibonacci_numbers

  private_class_method :new

  def initialize(fibonacci_numbers = FibonacciNumbers.new)
    @fibonacci_numbers = fibonacci_numbers

    freeze
  end

  def self.generate(length: 2)
    raise ArgumentError, 'Argument `length` is required.'                          if length.nil?
    raise ArgumentError, 'Argument `length` must be an instance of Integer class.' unless length.is_a?(Integer)
    raise ArgumentError, 'Argument `length` must be greater or equal to 2.'        unless length >= 2

    fibonacci_numbers = FibonacciNumbers.generate(length: length)

    new(fibonacci_numbers)
  end

  def length
    fibonacci_numbers.length
  end

  def to_a
    fibonacci_numbers.to_a
  end

  def to_s
    to_a.join(', ')
  end
end
