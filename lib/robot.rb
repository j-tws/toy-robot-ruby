# frozen_string_literal: true

class Robot
  DIRECTION = %i[north east south west].freeze
  attr_reader :bearing, :coordinates

  def orient(direction)
    raise ArgumentError unless DIRECTION.include?(direction)

    @bearing = direction
  end

  def turn_right
    next_direction = @bearing == :west ? 0 : DIRECTION.index(@bearing) + 1

    @bearing = DIRECTION[next_direction]
  end

  def turn_left
    next_direction = @bearing == :north ? 3 : DIRECTION.index(@bearing) - 1

    @bearing = DIRECTION[next_direction]
  end

  def at(x, y, board)
    raise ArgumentError, 'Argument must be a number' if !x.is_a?(Numeric) || !y.is_a?(Numeric)

    @coordinates = [x, y]
  end

  def advance
    x, y = @coordinates

    case @bearing
    when :north
      @coordinates = [x, y + 1]
    when :east
      @coordinates = [x + 1, y]
    when :south
      @coordinates = [x, y - 1]
    else :west
         @coordinates = [x - 1, y]
    end
  end
end
