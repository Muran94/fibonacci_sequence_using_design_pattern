# frozen_string_literal: true

require_relative './fibonacci_number'

# 1. ファーストクラスコレクション
# → コレクションに対するロジックをカプセル化し、かつ、高凝集にするためのデザインパターン。
# → ロジックの重複を防ぎ、修正漏れに伴うバグ発生のリスクを低減する.
#
class FibonacciNumbers
  FIRST_TWO_NUMBERS = [FibonacciNumber.new(0), FibonacciNumber.new(1)].freeze

  private attr_reader :collection

  def initialize(collection = FIRST_TWO_NUMBERS.dup)
    raise ArgumentError, 'Argument `collection` is required.'                                                           if collection.nil?
    raise ArgumentError, 'Argument `collection` must be an instance of Array Class, including FibonacciNumber Objects.' unless collection.is_a?(Array) && collection.all? { |fibonacci_number| fibonacci_number.is_a?(FibonacciNumber) }
    raise ArgumentError, 'Argument `collection` must contain 0 and 1 for the first two elements.'                       unless collection.first(2) == FIRST_TWO_NUMBERS

    @collection = collection

    freeze
  end

  def self.generate(length: 2)
    raise ArgumentError, 'Argument `length` is required.'                          if length.nil?
    raise ArgumentError, 'Argument `length` must be an instance of Integer class.' unless length.is_a?(Integer)
    raise ArgumentError, 'Argument `length` must be greater or equal to 2.'        unless length >= 2

    new.add_until_length_reaches(length)
  end

  def add
    number_to_add           = collection.last(2).sum(&:to_i)
    fibonacci_number_to_add = FibonacciNumber.new(number_to_add)
    collection_added        = collection.dup + [fibonacci_number_to_add]

    FibonacciNumbers.new(collection_added)
  end

  def add_until_length_reaches(length)
    new_fibonacci_numbers = self
    new_fibonacci_numbers = new_fibonacci_numbers.add until new_fibonacci_numbers.length >= length
    new_fibonacci_numbers
  end

  def length
    collection.length
  end

  def to_a
    collection.clone.map(&:to_i)
  end
end
