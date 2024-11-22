# frozen_string_literal: true

require_relative './lib/fibonacci_sequence'

puts FibonacciSequence.generate(length: 10).to_a
puts FibonacciSequence.generate(length: 10).to_s
