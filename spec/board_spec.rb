require 'board'

describe Board do

  let(:ship){double(:ship, hit: nil, size: 2, class: Ship, health: 2)}
  let(:ship_dead){double(:ship, hit: nil, size: 1, class: Ship, health: 0)}
  let(:ship_size_3){double(:ship , hit: nil, size: 3)}

  describe '#place' do

    it 'we can put a ship on the board' do
      subject.place(ship, 'A1', 'N')
      expect(subject.board.include?(ship)).to be_truthy
    end

    it 'when placing a ship of size 3 it occupies 3 board elements in direction given' do
      subject.place(ship_size_3, 'E5', 'N')
      expect( [ subject.board[24], subject.board[34], subject.board[44] ] ).to eq [ ship_size_3, ship_size_3, ship_size_3 ]
    end

    it 'ships cannot overlap' do
      subject.place(ship_size_3, 'E5', 'N')
      expect{subject.place(ship_size_3, 'D4', 'E')}.to raise_error "Unable to place ship. Either overlaps or placed off the board"
    end

    it 'raise error when ship is off the board' do
      expect{subject.place(ship_size_3, 'I5', 'S')}.to raise_error "Unable to place ship. Either overlaps or placed off the board"
    end

  end

  describe '#fire' do

    it 'reports a hit' do
      subject.place(ship, 'E2', 'N')
      expect{subject.fire('E2')}.to output("Hit!\n").to_stdout
    end

    it 'reports a miss' do
        expect{subject.fire('A1')}.to output("Miss!\n").to_stdout
    end

    it 'when ship is hit, call ship_hit method' do
      subject.place(ship, 'A1', 'E')
      expect(ship).to receive(:hit)
      subject.fire('A1')
    end

    it 'Congratulations message when all ships are sunk' do
      subject.place(ship_dead, 'E2', 'W')
      expect{subject.fire('E2')}.to output("Hit!\nCongratulations you have won the game!\n").to_stdout
    end

    it 'raises an error when we have a duplicate shot (hit)' do
      subject.place(ship_size_3, 'E5', 'N')
      subject.fire('E5')
      expect{subject.fire('E5')}.to raise_error "You've already recorded a hit in that location"
    end

    it 'raises an error when we have a duplicate shot (miss)' do
      subject.fire('E5')
      expect{subject.fire('E5')}.to raise_error "You've already recorded a miss in that location"
    end

  end

end