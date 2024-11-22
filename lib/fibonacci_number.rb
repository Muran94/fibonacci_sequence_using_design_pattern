class FibonacciNumber
  protected attr_reader :value

  def initialize(value)
    raise ArgumentError, 'Argument `value` is required.' if value.nil?
    raise ArgumentError, 'Argument `value` must be an instance of Integer class.' unless value.is_a?(Integer)
    raise ArgumentError, 'Argument `value` must be greater or equal to 0.' unless value >= 0

    @value = value

    freeze
  end

  def to_i
    value
  end
end
