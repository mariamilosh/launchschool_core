class Hand
  attr_reader :cards
  attr_writer :cards

  def initialize(opening_bet, split_card*)
    @cards = [split_card]
    @bet = opening_bet
  end

  def hit(shoe)
    @cards << shoe.deal_Card
  end

  def to_a
    cards
  end
end

class Player
  attr_reader :hands
  def initialize(player_type=:human, name, bankroll=nil)
    @bankroll = bankroll
    @name = name
    # @hand1, @hand2, @hand3, @hand4 = [], [], [], []
    @hands = []
  end

  def split(hand, bet)
    @hands.insert(hands.index(hand) + 1,
                  Hand.new(opening_bet, hand.cards.push!))
  end
  # hit groups: group 1 and group 2. Start with only cards in group 1

  # def hands
  #   # [@hand1, @hand2, @hand3, @hand4].select { |hand| hand }
  # end

  def to_s
    @name
  end
end

class Deck
  SUITS = { :hearts => "\u2661", :diamonds => "\u2662",
            :spades => "\u2660", :clubs => "\u2663" }
  FACE_CARDS = { :ace => [1, 11], :king => [10],
                 :queen => [10], :jack => [10]}
  def initialize
    @cards = []
    SUITS.each do |suit|
      FACE_CARDS.each do |card, value|
        @cards << Card.new(card, suit, card.to_s[0].upcase, value)
      end
      (2..10).each do |num|
        @cards << Card.new(num.to_s, suit, num.to_s, [num])
      end
    end
  end

  def to_a
    @cards
  end
end

class Card
  attr_reader :suit, :type, :value, :symbol

  def initialize(type, suit, symbol, value)
    @suit = suit
    @type = type
    @value = value
    @symbol = symbol
  end
end

class Shoe
  attr_reader :shoe

  def initialize(num_decks)
    @quantity = num_decks
    @decks = []
    (1..@quantity).each do |num|
      @decks += Deck.new.to_a
    end
    @shoe = @decks.dup
    shuffle_cards
    place_cut_card
  end

  def deal_card
    shoe.shift!
  end

  def shuffle_cards
    @shoe = @decks.dup.shuffle
    place_cut_card
  end

  def place_cut_card
    @cut_card_index = (15..(shoe.size/2)).sample
  end

  def to_a
    shoe
  end

  def [](index)
    shoe[index]
  end

  def reshuffle?
    shoe.size <= @cut_card_index
  end
end

class TOGame
  STARTING_BANKROLL = 500
  WIN_MULTIPLIER = 1.5
  NATURAL_MULTIPLIER = 2
  MAX_DECKS = 8
  MIN_DECKS = 1

  def play
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def clear
    system "clear"
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
    puts ""
  end

  def display_goodbye_message
    puts ""
    # display_final_score
    puts "Thanks for playing Twenty-One! Goodbye!"
  end

  def deal_hand_animation(hands)
    hands
    game_screen
  end

# How to get one line at a time
#
  def deal_starting_hands
    clear_screen
    game_screen
    # hit(game_stuff['player']['hands'][0]['hand'], game_stuff)
    # hit(game_stuff['dealer']['hidden_card'], game_stuff)
    # deal_hand_animation(game_stuff)
    # game_stuff['dealer']['hands'][0]['hand'].push({ 'card' => 'hidden',
    #                                                 'chr' => '  ', 'value' => [0],
    #                                                 'suit' => ' ' })
    # deal_hand_animation(game_stuff)
    # hit(game_stuff['player']['hands'][0]['hand'], game_stuff)
    # deal_hand_animation(game_stuff)
    # hit(game_stuff['dealer']['hands'][0]['hand'], game_stuff)
    # deal_hand_animation(game_stuff)
  end

  def get_deck_quantity
    num_decks = nil
    loop do
      puts "How many decks? (#{MIN_DECKS}-#{MAX_DECKS})"
      num_decks = gets.chomp.to_i
      break if num_decks === (1..8)
      puts "Answer invalid"
    end
    num_decks
  end

  def get_name

  end

  def new_deal

  end

  def new_game
    @num_decks = get_deck_quantity
    @shoe = Shoe.new(@num_decks)
    @player = Player.new(:human, get_name, STARTING_BANKROLL)
    @dealer = Player.new(@player = Player.new(:dealer, 'Dealer')
  end

  def play_again?
    answer = nil
    loop do
      puts "Play another hand? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset
    @shoe = Shoe.new(@num_decks)
  end

  def game_screen
  end

  def main_game
    loop do
      new_game
      loop do
        # display_board
        # player_move
        # display_result
        # update_score
        # break if grand_winner
        # break unless play_again?
        # reset
        # display_play_again_message
      end
    end
  end

end

game = TOGame.new
game.play
