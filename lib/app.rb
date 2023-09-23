require_relative 'display'
require_relative 'simulator'
require 'pry'

class App
  attr_reader :display, :simulator

  def initialize
    @display = Display.new
    @simulator = Simulator.new
  end

  def run
    loop do
      # show start menu
      @display.start_menu

      # begin process of building board
      board_rows_input = @display.get_board_rows
      baord_columns_input = @display.get_board_columns
      @simulator.setup_board(board_rows_input, baord_columns_input)

      # show how board looks like after building
      puts 'Here is how your board look like'
      @simulator.board.print_board

      # begin placing robot
      puts 'Now place where you want your robot to start'
      robot_column_input = @display.get_robot_start_column
      robot_row_input = @display.get_robot_start_row
      robot_bearing_input = @display.get_robot_start_bearing
      @simulator.place(x: robot_column_input, y: robot_row_input, direction: robot_bearing_input)

      puts 'This is where your robot start'
      @simulator.board.print_board

      # begin command input
      puts 'Now the fun begins'
      puts 'You can enter a series of commands where you will see your robot moving around the board'

      loop do
        puts 'Commands can be only either:'
        puts "'R', which means ask the robot to turn right from where it is currently facing"
        puts "'L', which means ask the robot to turn left from where it is currently facing"
        puts "'A', which means ask the robot to advance one cell from where it is facing"
  
        commands = @display.get_user_commands
        system 'clear'
        @simulator.evaluate(commands)
      end
    end
  end
end
pry
