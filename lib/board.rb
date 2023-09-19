require 'pry'
require_relative 'robot'

class Board
  attr_reader :grid, :rows, :columns, :current_robot_location

  CELL = '⬜'
  ROBOT = '🤖'

  def initialize(rows, columns)
    raise ArgumentError, 'Argument must be a number' if !rows.is_a?(Numeric) || !columns.is_a?(Numeric)
    raise ArgumentError, 'Argument must be > 0' if rows < 0 || columns < 0

    @rows = rows
    @columns = columns
    @grid = Array.new(rows) { Array.new(columns, CELL) }
  end

  def place_robot(robot, x, y)
    if x > @columns || y > @rows 
      raise ArgumentError, 'Robot must be within grid confinement'
    end

    robot.at(x, y)
    @grid[-y][x - 1] = ROBOT
  end

  def reset_board
    @grid = Array.new(rows) { Array.new(columns, CELL) }
  end

  def robot_location_on_board(robot)
    reset_board
    @grid[-robot.coordinates.last][robot.coordinates.first - 1] = ROBOT
    # print_board
  end

  def print_board
    puts @grid.map { |row| row.join(' ') }
  end
  pry
end