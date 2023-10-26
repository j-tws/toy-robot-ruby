require 'simulator'
require 'robot'

RSpec.describe Simulator do
  context '#initalize' do
    it 'should create an instance variable of robot' do
      expect(subject.robot).to be_a_kind_of(Robot)
    end
  end

  context '#setup_board' do
    it 'should create an instance variable of board' do
      subject.setup_board(3, 3)

      expect(subject.board.rows).to eq(3)
      expect(subject.board.columns).to eq(3)
    end
  end

  context '#instructions' do
    it 'should map given string into correct arrays of instructions' do
      expect(subject.instructions('LRA')).to eq([:turn_left, :turn_right, :advance])
      expect(subject.instructions('AARLA')).to eq([:advance, :advance, :turn_right, :turn_left, :advance])
      expect(subject.instructions('RALA')).to eq([:turn_right, :advance, :turn_left, :advance])
    end
  end

  context '#place' do
    it 'should raise error if there is no board' do
      expect { subject.place(x: 3, y: 3, direction: :north) }.to raise_error(Simulator::NoBoardError)
    end

    it 'should raise error if x and y arguments are not digits' do
      subject.setup_board(3, 3)
      expect { subject.place(x: 'hello', y: 'world', direction: :north) }.to raise_error(ArgumentError)
    end

    it 'should raise error if x and y arguments are out of board boundaries' do
      subject.setup_board(3, 3)
      expect { subject.place(x: 5, y: 5, direction: :north) }.to raise_error(ArgumentError)
    end

    context 'when arguments are correct' do
      before do
        subject.setup_board(5, 5)
        subject.place(x: 3, y: 3, direction: :north)
      end

      it 'should place robot with correct coordinates, update board with correct robot placement, and robot will have correct bearing' do
        expect(subject.robot.coordinates).to eq([3, 3])
        expect(subject.robot.bearing).to eq(:north)
        expect(subject.board.grid).to eq([
          ['⬜', '⬜', '⬜', '⬜', '⬜'],
          ['⬜', '⬜', '⬜', '⬜', '⬜'],
          ['⬜', '⬜', '🤖', '⬜', '⬜'],
          ['⬜', '⬜', '⬜', '⬜', '⬜'],
          ['⬜', '⬜', '⬜', '⬜', '⬜']
        ])
      end
    end
  end

  context '#check_if_robot_hit_boundary' do
    it 'should return nil if instruction given is not advance' do
      expect(subject.check_if_robot_hit_boundary(:turn_left)).to be_nil
    end

    it 'should raise error when robot is going to hit any board edge' do
      subject.setup_board(3, 3)

      subject.place(x: 1, y: 1, direction: :south)
      expect { subject.check_if_robot_hit_boundary(:advance) }.to raise_error(Simulator::HitBoardBoundaryError)

      subject.place(x: 1, y: 1, direction: :west)
      expect { subject.check_if_robot_hit_boundary(:advance) }.to raise_error(Simulator::HitBoardBoundaryError)

      subject.place(x: 3, y: 3, direction: :north)
      expect { subject.check_if_robot_hit_boundary(:advance) }.to raise_error(Simulator::HitBoardBoundaryError)

      subject.place(x: 3, y: 3, direction: :east)
      expect { subject.check_if_robot_hit_boundary(:advance) }.to raise_error(Simulator::HitBoardBoundaryError)
    end
  end

  context '#evaluate' do
    before do
      subject.setup_board(5, 6)
      subject.place(x: 3, y: 3, direction: :north)
    end

    it 'should run the passed commands correctly' do
      subject.evaluate('RALA')
      expect(subject.robot.coordinates).to eq([4, 4])
      expect(subject.board.grid).to eq([
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '🤖', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜']
        ])
      expect(subject.robot.bearing).to eq(:north)
    end

    it 'should run complex commands correctly' do
      subject.evaluate('AALAALAALARAALAA')
      expect(subject.robot.coordinates).to eq([4, 1])
      expect(subject.board.grid).to eq([
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜', '🤖', '⬜', '⬜']
        ])
      expect(subject.robot.bearing).to eq(:east)
    end

    it 'should raise error when robot is about to collide with boundary' do
      expect { subject.evaluate('AAAA') }.to raise_error(Simulator::HitBoardBoundaryError)
    end
  end
end
