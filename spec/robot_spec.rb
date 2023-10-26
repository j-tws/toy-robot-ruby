require 'robot'

RSpec.describe Robot do
  context '#orient' do
    [:north, :south, :east, :west].each do |direction|
      it 'should have a bearing set for robot' do
        subject.orient(direction)

        expect(subject.bearing).to eq(direction)
      end
    end

    it 'should raise error when invalid direction is given' do
      expect { subject.orient(:hello) }.to raise_error(ArgumentError)
    end
  end

  context '#turn_right' do
    context 'when turning right from north' do
      it 'should face the robot to the correct direction' do
        subject.orient(:north)
        subject.turn_right

        expect(subject.bearing).to eq(:east)
      end
    end

    context 'when turning right from east' do
      it 'should face the robot to the correct direction' do
        subject.orient(:east)
        subject.turn_right

        expect(subject.bearing).to eq(:south)
      end
    end

    context 'when turning right from south' do
      it 'should face the robot to the correct direction' do
        subject.orient(:south)
        subject.turn_right

        expect(subject.bearing).to eq(:west)
      end
    end

    context 'when turning right from west' do
      it 'should face the robot to the correct direction' do
        subject.orient(:west)
        subject.turn_right

        expect(subject.bearing).to eq(:north)
      end
    end
  end

  context '#turn_left' do
    context 'when turning right from north' do
      it 'should face the robot to the correct direction' do
        subject.orient(:north)
        subject.turn_left

        expect(subject.bearing).to eq(:west)
      end
    end

    context 'when turning right from east' do
      it 'should face the robot to the correct direction' do
        subject.orient(:east)
        subject.turn_left

        expect(subject.bearing).to eq(:north)
      end
    end

    context 'when turning right from south' do
      it 'should face the robot to the correct direction' do
        subject.orient(:south)
        subject.turn_left

        expect(subject.bearing).to eq(:east)
      end
    end

    context 'when turning right from west' do
      it 'should face the robot to the correct direction' do
        subject.orient(:west)
        subject.turn_left

        expect(subject.bearing).to eq(:south)
      end
    end
  end

  context '#at' do
    it 'should set coordinates for robot' do
      subject.at(1, 5)

      expect(subject.coordinates).to eq([1, 5])
    end

    it 'should raise error when argument is not number' do
      expect { subject.at('hello', 'world') }.to raise_error(ArgumentError)
    end
  end

  context '#advance' do
    before { subject.at(1, 1) }

    it 'should advance correctly when robot is facing north' do
      subject.orient(:north)
      subject.advance

      expect(subject.coordinates).to eq([1, 2])
    end

    it 'should advance correctly when robot is facing east' do
      subject.orient(:east)
      subject.advance

      expect(subject.coordinates).to eq([2, 1])
    end

    it 'should advance correctly when robot is facing south' do
      subject.orient(:south)
      subject.advance

      expect(subject.coordinates).to eq([1, 0])
    end
  end
end
