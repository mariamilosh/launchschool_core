class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

# Reset deck when it runs out of cards
# Generate set of 52 shuffled cards
  def initialize
    @deck = []
    reset
  end

# Deal one card from deck
  def draw
    reset if deck.empty?
    deck.shift
  end

  private
  attr_accessor :deck

    def create_new
      RANKS.each do |rank|
        SUITS.each do |suit|
          deck << Card.new(rank, suit)
        end
      end
    end

    def reset
      create_new
      deck.shuffle!
    end
end

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

# class Card
#   attr_reader :rank, :suit
#
#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end
# end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
