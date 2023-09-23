class Display
  def start_menu
    puts <<~START_MENU
      ---------------------------------------------------
      |          WELCOME TO TOY ROBOT SIMULATOR         |
      ---------------------------------------------------


      First by starting up your board!
    START_MENU
  end

  def get_board_rows
    puts 'Enter the amount of rows you want to have for your board:'
    gets.chomp.to_i
  end
  
  def get_board_columns
    puts 'Enter the amount of columns you want to have for your board:'
    gets.chomp.to_i
  end
  
  def get_robot_start_row
    puts "Let's start which row do you want to place your robot:"
    gets.chomp.to_i
  end
  
  def get_robot_start_column
    puts 'Which column do you want to place your robot:'
    gets.chomp.to_i
  end

  def get_robot_start_bearing
    puts 'Enter where you want your robot to face:'
    gets.chomp.to_sym
  end

  def get_user_commands
    puts 'Enter your commands here:'
    gets.chomp
  end

  # def run_app
  #   loop do
  #     start_menu
  #     get_board_rows
  #     get_board_columns
  #     break
  #   end
  # end
end
