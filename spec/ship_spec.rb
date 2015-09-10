require 'ship'

describe Ship do

  let(:subject){Ship.new(3)}

  it 'ship has health which is equal to its size' do
    ship=Ship.new(5)
    expect(ship.size).to eq(ship.health)
  end

  it 'lets us choose a size' do
    ship = Ship.new(5)
    expect(ship.size).to eq 5
  end

  it 'loses a life when it gets shot' do
    health = subject.health
    subject.hit
    expect(subject.health).to eq(health-1)
  end

  it 'tells us when it dead' do
    ship = Ship.new(5)
    4.times {ship.hit}
    expect{ship.hit}.to output("You sunk my battleship!\n").to_stdout
  end

  it 'ship of size five, does not return dead when hit for the first time' do
    ship = Ship.new(5)
    expect{subject.hit}.not_to output("Dead!\n").to_stdout
  end

end
