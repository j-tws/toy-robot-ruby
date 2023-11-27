require_relative 'display'
require_relative 'simulator'

class App
  # attr_reader :display, :simulator
  MESSAGES = {
    start_menu: <<~START_MENU,
      ---------------------------------------------------
      |          WELCOME TO TOY ROBOT SIMULATOR         |
      ---------------------------------------------------


      First by starting up your board!
    START_MENU
    enter_board_rows: 'Enter the amount of rows you want to have for your board:',
    enter_board_cols: 'Enter the amount of columns you want to have for your board:',
    enter_robot_start_col: "Let's start which column do you want to place your robot:",
    enter_robot_start_row: 'Which row do you want to place your robot:',
    enter_robot_bearing: "Enter where you want your robot to face (only enter 'north', 'south', 'east', 'west'):",
    enter_command: 'Enter your commands here:',
    build_board_complete: 'Here is how your board look like',
    start_place_robot: 'Now place where you want your robot to start',
    robot_starting_position_message: 'This is where your robot start',
    run_command_intro_message: "Now the fun begins\nYou can enter a series of commands where you will see your robot moving around the board",
    command_instructions: <<~COMMAND_INSTRUCTIONS,
      Commands can be only either:
      R, which means ask the robot to turn right from where it is currently facing
      L, which means ask the robot to turn left from where it is currently facing
      A, which means ask the robot to advance one cell from where it is facing
      \n
      Example command: RLAR
      It means it command the robot to turn right, turn left, advance a step, and finish by turning right
    COMMAND_INSTRUCTIONS
    current_command: 'Current command:',
    robot_coordinates: 'Robot coordinates:',
    robot_bearing: 'Robot bearing'
  }.freeze

  def initialize
    @display = Display.new
    @simulator = Simulator.new
  end

  def build_board
    loop do
      @display.print(MESSAGES[:enter_board_cols])
      board_columns_input = @display.get_input_to_int

      @display.print(MESSAGES[:enter_board_rows])
      board_rows_input = @display.get_input_to_int

      @simulator.setup_board(board_rows_input, board_columns_input)

      @display.print(MESSAGES[:build_board_complete])
      @display.draw(@simulator.board.board_with_axis)

      return if @simulator.board
    rescue ArgumentError => e
      @display.print(e)
      next
    end
  end

  def place_robot
    @display.print(MESSAGES[:start_place_robot])

    loop do
      @display.print(MESSAGES[:enter_robot_start_col])
      robot_column_input = @display.get_input_to_int

      @display.print(MESSAGES[:enter_robot_start_row])
      robot_row_input = @display.get_input_to_int

      @display.print(MESSAGES[:enter_robot_bearing])
      robot_bearing_input = @display.get_input_to_sym

      @simulator.place(x: robot_column_input, y: robot_row_input, direction: robot_bearing_input)

      @display.print(MESSAGES[:robot_starting_position_message])
      @display.draw(@simulator.board.board_with_axis)

      return if @simulator.robot.bearing
    rescue ArgumentError => e
      @display.print(e)
      next
    end
  end

  def run_commands
    @display.print(MESSAGES[:run_command_intro_message])

    loop do
      @display.print(MESSAGES[:command_instructions])
      @display.print(MESSAGES[:enter_command])

      commands = @display.get_input_as_str
      system 'clear'

      @simulator.evaluate(commands) do |command|
        @display.print("#{MESSAGES[:current_command]} #{command}\n")
        @display.draw(@simulator.board.board_with_axis)
        @display.print("#{MESSAGES[:robot_coordinates]} #{@simulator.robot.coordinates}")
        @display.print("#{MESSAGES[:robot_bearing]} #{@simulator.robot.bearing}")
      end

      @display.print(MESSAGES[:enter_command])
    rescue ArgumentError, Simulator::HitBoardBoundaryError => e
      @display.print(e)
      next
    end
  end

  def run
    loop do
      @display.print(MESSAGES[:start_menu])
      build_board
      place_robot
      run_commands
    end
  end
end

App.new.run
