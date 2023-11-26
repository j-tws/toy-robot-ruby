class Robot
  DIRECTION = %i[north east south west].freeze
  attr_reader :bearing, :coordinates

  def orient(direction)
    raise ArgumentError, 'Please only enter valid direction (north, south, east, or west)' unless DIRECTION.include?(direction)

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

  def at(x, y)
    raise ArgumentError, 'Please only enter numbers for row and column' if !x.is_a?(Integer) || !y.is_a?(Integer)

    @coordinates = [x, y]
  end

  def advance
    case @bearing
    when :north
      @coordinates[1] += 1
    when :east
      @coordinates[0] += 1
    when :south
      @coordinates[1] -= 1
    else
      @coordinates[0] -= 1
    end
  end
end
