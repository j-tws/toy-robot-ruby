class Display
  def start_menu
    puts <<~START_MENU
      =============WELCOME TO ROBOT SIM==============
      First by starting up your board!
      Enter the amount of rows and columns you wish to have
    START_MENU
  end

  

end

d = Display.new
d.start_menu