# frozen_string_literal: true

require_relative './lib/fibonacci_sequence'

puts FibonacciSequence.generate(length: 2).to_s
puts FibonacciSequence.generate(length: 5).to_s
puts FibonacciSequence.generate(length: 10).to_s
