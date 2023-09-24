require 'pry'
class Board
  attr_reader :grid, :rows, :columns, :clean_grid

  CELL = '⬜'

  def initialize(rows, columns)
    raise ArgumentError, 'Please enter numbers only for rows and columns' if rows.scan(/\D/).any? || columns.scan(/\D/).any?

    rows_number = rows.to_i
    columns_number = columns.to_i

    raise ArgumentError, 'Number must be more than 0 for both rows and columns' if rows_number <= 0 || columns_number <= 0

    @rows = rows_number
    @columns = columns_number
    @grid = Array.new(@rows) { Array.new(@columns, CELL) }
  end

  def reset
    @grid = Array.new(@rows) { Array.new(@columns, CELL) }
  end

  def print_board
    puts @grid.map { |row| row.join(' ') }
    puts "\n\n"
  end
end
# pry