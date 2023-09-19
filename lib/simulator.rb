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
    @board.place_robot(x, y)

    @robot.at(x, y)
    @robot.orient(direction)
  end

  def evaluate(commands)
    instructions_to_run = instructions(commands)

    instructions_to_run.each do |instruction|
      @robot.send(instruction)
    end
  end
  # pry
end
