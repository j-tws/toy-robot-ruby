class Board
  attr_reader :grid, :rows, :columns, :clean_grid

  CELL = '⬜'

  def initialize(rows, columns)
    raise ArgumentError, 'Argument must be a number' if !rows.is_a?(Numeric) || !columns.is_a?(Numeric)
    raise ArgumentError, 'Argument must be > 0' if rows < 0 || columns < 0

    @rows = rows
    @columns = columns
    @grid = Array.new(rows) { Array.new(columns, CELL) }
  end

  def reset
    @grid = Array.new(rows) { Array.new(columns, CELL) }
  end

  def print_board
    puts @grid.map { |row| row.join(' ') }
    puts "\n\n"
  end
end