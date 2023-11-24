require_relative 'board'
require_relative 'robot'
require 'pry'

class Simulator
  class HitBoardBoundaryError < StandardError; end
  class NoBoardError < StandardError; end

  attr_reader :robot, :board

  INSTRUCTIONS_SET = {
    L: :turn_left,
    R: :turn_right,
    A: :advance
  }.freeze

  ROBOT = '🤖'.freeze

  def initialize
    @robot = Robot.new
  end

  def setup_board(x, y)
    @board = Board.new(x, y)
  end

  def instructions(string)
    string.split('').map { |char| INSTRUCTIONS_SET[char.to_sym] }
  end

  def place(x:, y:, direction:)
    raise NoBoardError, 'Please create a board first' unless @board

    raise ArgumentError, 'Please only enter numbers for row and column' if x.is_a?(String) || y.is_a?(String)

    if x > @board.columns || y > @board.rows || x < 1 || y < 1
      raise ArgumentError, "Robot must be within grid confinement (number of rows: #{@board.rows}, number of columns: #{@board.columns}"
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
      sleep 1 unless defined?(RSpec)

      check_if_robot_hit_boundary(instruction)
      system 'clear'
      @robot.send(instruction)
      update_robot_location_on_board

      print_board_with_robot_and_instruction_info(instruction)
    end
  end

  def print_board_with_robot_and_instruction_info(instruction)
    puts "Current command: #{instruction}"
    puts "\n"
    @board.print_board
    puts "\n"
    puts "Robot coordinates: #{@robot.coordinates}"
    puts "Robot bearing: #{@robot.bearing}"
  end
end
