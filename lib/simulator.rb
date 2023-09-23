require_relative 'board'
require_relative 'robot'
require 'pry'

class Simulator
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
    if x > @board.columns || y > @board.rows || x < 1 || y < 1 
      raise ArgumentError, 'Robot must be within grid confinement'
    end

    @robot.at(x, y)
    @board.grid[-@robot.coordinates.last][@robot.coordinates.first - 1] = ROBOT
    @robot.orient(direction)
  end

  def update_robot_location_on_board
    @board.reset
    @board.grid[-@robot.coordinates.last][@robot.coordinates.first - 1] = ROBOT
  end

  def check_if_robot_hit_boundary(instruction)
    return unless instruction == INSTRUCTIONS_SET[:A]

    return unless @robot.coordinates.last == 1 && @robot.bearing == :south
    return unless @robot.coordinates.last == @board.rows && @robot.bearing == :north
    return unless @robot.coordinates.first == 1 && robot.bearing == :west
    return unless @robot.coordinates.first == @board.columns && @robot.bearing == :east

    raise 'you have hit a wall'
  end

  def evaluate(commands)
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
  # pry
end

s = Simulator.new
s.setup_board(10,10)
s.place(x: 3, y: 3, direction: :north)
# pry