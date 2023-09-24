require_relative 'board'
require_relative 'robot'

class Simulator
  class HitBoardBoundaryError < StandardError
  end

  attr_reader :robot, :board

  INSTRUCTIONS_SET = {
    L: :turn_left,
    R: :turn_right,
    A: :advance,
  }

  ROBOT = '🤖'

  def initialize
    @robot = Robot.new
  end

  def setup_board(x, y)
    @board = Board.new(x, y)
  end
  
  def instructions(string)
    string.split('').map{ |char| INSTRUCTIONS_SET[char.to_sym] }
  end

  def place(x:, y:, direction:)
    raise ArgumentError, 'Please enter numbers only for rows and columns' if x.scan(/\D/).any? || y.scan(/\D/).any?

    x_number = x.to_i
    y_number = y.to_i

    if x_number > @board.columns || y_number > @board.rows || x_number < 1 || y_number < 1 
      raise ArgumentError, "Robot must be within grid confinement (number of rows: #{@board.rows}, number of columns: #{@board.columns}"
    end

    @robot.at(x_number, y_number)
    @board.grid[-@robot.coordinates.last][@robot.coordinates.first - 1] = ROBOT
    @robot.orient(direction)
  end

  def update_robot_location_on_board
    @board.reset
    @board.grid[-@robot.coordinates.last][@robot.coordinates.first - 1] = ROBOT
  end

  def check_if_robot_hit_boundary(instruction)
    return unless instruction == INSTRUCTIONS_SET[:A]

    if @robot.coordinates.last == 1 && @robot.bearing == :south ||
     @robot.coordinates.last == @board.rows && @robot.bearing == :north ||
     @robot.coordinates.first == 1 && robot.bearing == :west ||
     @robot.coordinates.first == @board.columns && @robot.bearing == :east

      raise HitBoardBoundaryError, "You've hit a wall :( all upcoming commands are cancelled"
    end
  end

  def evaluate(commands)
    raise ArgumentError, "Please only enter commands containing letters 'R', 'L', 'A'" if commands.scan(/[^RLA]/).any?

    instructions_to_run = instructions(commands)

    instructions_to_run.each do |instruction|
      sleep 1
      check_if_robot_hit_boundary(instruction)
      system 'clear'
      @robot.send(instruction)
      update_robot_location_on_board
      @board.print_board
    end
  end
end

# s = Simulator.new
# s.setup_board('5','5')
# s.place(x: '3', y: '3', direction: :west)
# s.evaluate('AAAAA')
# pry