class Ship

  attr_reader :size , :health

  def initialize(size)
    @size = size
    @health = size
  end

  def hit
    @health = health - 1
    puts "You sunk my battleship!" if health == 0
  end

end