class Board
  attr_reader :grid, :rows, :columns, :clean_grid

  CELL = '⬜'

  def initialize(rows, columns)
    raise ArgumentError, 'Please enter numbers only for rows and columns' if rows.is_a?(String) || columns.is_a?(String)

    raise ArgumentError, 'Number must be more than 0 for both rows and columns' if rows <= 0 || columns <= 0

    @rows = rows
    @columns = columns
    @grid = Array.new(@rows) { Array.new(@columns, CELL) }
  end

  def reset
    @grid = Array.new(@rows) { Array.new(@columns, CELL) }
  end

  def print_board
    x_axis = [*1..@columns].map{ |n| "#{n} "}
    grid_with_x_axis = [*@grid, x_axis]
 
    grid_with_x_and_y_axis = grid_with_x_axis.map.with_index do |row, index|
      if index == @rows
        [' ', *row].join(' ')
      else
        [@rows - index, *row].join(' ')
      end
    end

    puts grid_with_x_and_y_axis
    puts "\n\n"
  end
end
