require 'board'

RSpec.describe Board do
  context '#initalize' do
    context 'when board is initalized with correct arguments' do
      it 'should store correct state of rows, columns, and grid' do
        board = Board.new(3, 3)

        expect(board.rows).to eq(3)
        expect(board.columns).to eq(3)
        expect(board.grid).to eq([
          ['⬜', '⬜', '⬜'],
          ['⬜', '⬜', '⬜'],
          ['⬜', '⬜', '⬜'],
        ])
      end
    end

    context 'when board is initalized with arguments that are not number' do
      it 'should raise error' do
        expect { Board.new('hello', 'world') }.to raise_error(ArgumentError)
      end
    end

    context 'when board is initalized with arguments that are equal or less than 0' do
      it 'should raise error' do
        expect { Board.new(0, -2) }.to raise_error(ArgumentError)
      end
    end
  end

  context '#reset' do
    it 'should reset grid to its initial look' do
      board = Board.new(3, 3)

      board.grid[1][2] = 'something'
      board.reset

      expect(board.grid).to eq([
        ['⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜'],
        ['⬜', '⬜', '⬜'],
      ])
    end
  end
end