class Display
  def start_menu
    puts <<~START_MENU
      ---------------------------------------------------
      |          WELCOME TO TOY ROBOT SIMULATOR         |
      ---------------------------------------------------


      First by starting up your board!
    START_MENU
  end

  def parse_input_to_integer
    input = gets.chomp
    if input == 'exit'
      exit(true)
    elsif input.scan(/\D/).any?
      input
    else
      input.to_i
    end
  end

  def get_board_rows
    puts 'Enter the amount of rows you want to have for your board:'
    parse_input_to_integer
  end

  def get_board_columns
    puts 'Enter the amount of columns you want to have for your board:'
    parse_input_to_integer
  end

  def get_robot_start_row
    puts 'Which row do you want to place your robot:'
    parse_input_to_integer
  end

  def get_robot_start_column
    puts "let's start which column do you want to place your robot:"
    parse_input_to_integer
  end

  def get_robot_start_bearing
    puts "Enter where you want your robot to face (only enter 'north', 'south', 'east', 'west'):"
    exit_or_proceed(gets.chomp).to_sym
  end

  def get_user_commands
    puts 'Enter your commands here:'
    exit_or_proceed(gets.chomp)
  end

  def build_board_complete_message
    puts 'Here is how your board look like'
  end

  def start_place_robot_message
    puts 'Now place where you want your robot to start'
  end

  def show_robot_starting_position_message
    puts 'This is where your robot start'
  end

  def show_run_command_intro_message
    puts 'Now the fun begins'
    puts 'You can enter a series of commands where you will see your robot moving around the board'
  end

  def show_command_instructions
    puts <<~COMMAND_INSTRUCTIONS
      Commands can be only either:
      R, which means ask the robot to turn right from where it is currently facing
      L, which means ask the robot to turn left from where it is currently facing
      A, which means ask the robot to advance one cell from where it is facing
      \n
      Example command: RLAR
      It means it command the robot to turn right, turn left, advance a step, and finish by turning right
    COMMAND_INSTRUCTIONS
  end

  def exit_or_proceed(input)
    input == 'exit' ? exit(true) : input
  end
end
