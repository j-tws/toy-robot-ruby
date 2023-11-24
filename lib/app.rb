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
      @display.print_board(@simulator.board.board_with_axis)

      return if @simulator.board
    rescue ArgumentError => e
      @display.print_error(e)
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
      @display.print_board(@simulator.board.board_with_axis)

      return if @simulator.robot.bearing
    rescue ArgumentError => e
      @display.print_error(e)
      next
    end
  end

  def run_commands
    @display.show_run_command_intro_message

    loop do
      @display.show_command_instructions

      commands = @display.get_user_commands
      system 'clear'
      @simulator.evaluate(commands) { |outcome| @display.print_outcome(@simulator.robot, @simulator.board, outcome) }
      @display.print_board(@simulator.board.board_with_axis)
      @display.enter_another_command
    rescue ArgumentError, Simulator::HitBoardBoundaryError => e
      @display.print_error(e)
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
