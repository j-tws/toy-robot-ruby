require 'pry'

class Board
  attr_reader :grid, :rows, :columns

  CELL = '⬜'
  ROBOT = '🤖'

  def initialize(rows, columns)
    raise ArgumentError, 'Argument must be a number' if !rows.is_a?(Numeric) || !columns.is_a?(Numeric)

    @rows = rows
    @columns = columns
    @grid = Array.new(rows) { Array.new(columns, CELL) }
  end

  def insert_robot(x, y)
    if x > @columns || y > @rows
      raise ArgumentError, 'Robot must be placed within grid confinement'
    end

    @grid[y][x] = ROBOT
    print_board
  end

  def print_board
    puts @grid.map { |row| row.join(' ') }
  end

  pry
end