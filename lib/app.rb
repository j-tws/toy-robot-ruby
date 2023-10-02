require_relative 'display'
require_relative 'simulator'

class App
  attr_reader :display, :simulator

  def initialize
    @display = Display.new
    @simulator = Simulator.new
  end

  def build_board
    loop do
      board_rows_input = @display.get_board_rows
      baord_columns_input = @display.get_board_columns
      @simulator.setup_board(board_rows_input, baord_columns_input)
  
      @display.build_board_complete_message
      @simulator.board.print_board

      break if @simulator.board
    rescue ArgumentError => e
      puts e
      next
    end
  end

  def place_robot
    @display.start_place_robot_message
  
    loop do
      robot_column_input = @display.get_robot_start_column
      robot_row_input = @display.get_robot_start_row
      robot_bearing_input = @display.get_robot_start_bearing
      @simulator.place(x: robot_column_input, y: robot_row_input, direction: robot_bearing_input)

      @display.show_robot_starting_position_message
      @simulator.board.print_board

      break if @simulator.robot.bearing
    rescue ArgumentError => e
      puts e
      next
    end
  end

  def run_commands
    @display.show_run_command_intro_message

    loop do
      @display.show_command_instructions

      commands = @display.get_user_commands
      system 'clear'
      @simulator.evaluate(commands)
      @simulator.board.print_board
      puts 'Feel free to enter another set of commands'

    rescue ArgumentError, Simulator::HitBoardBoundaryError => e
      puts e
      next
    end
  end

  def run
    loop do
      @display.start_menu
      build_board
      place_robot
      run_commands
    end
  end
end

App.new.run
