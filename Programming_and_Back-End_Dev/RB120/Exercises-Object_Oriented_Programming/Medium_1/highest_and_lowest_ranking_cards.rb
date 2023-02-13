class Card
  include Comparable
  attr_reader :rank, :suit
  CARD_VALUES = {'Ace'=>14, 'King'=>13, 'Queen'=>12, 'Jack'=>11}
  SUIT_VALUES = {'Spades'=>4, 'Hearts'=>3, 'Clubs'=>2, 'Diamonds'=>1}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    unless rank.to_i == rank
      CARD_VALUES[rank]
    else
      rank
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    if rank == other.rank
      SUIT_VALUES[suit] <=> SUIT_VALUES[other.suit]
    else
      value <=> other.value
    end
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

puts ""
cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Spades'),
         Card.new(9, 'Diamonds')]
puts cards.min
puts cards.max
