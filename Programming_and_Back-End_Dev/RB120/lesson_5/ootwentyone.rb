# class Hand
#   attr_reader :cards
#   attr_writer :cards

#   def initialize(opening_bet, split_card*)
#     @cards = [split_card]
#     @bet = opening_bet
#   end

#   def hit(shoe)
#     @cards << shoe.deal_Card
#   end

#   def to_a
#     cards
#   end
# end

# class Player
#   attr_reader :hands
#   def initialize(player_type=:human, name, bankroll=nil)
#     @bankroll = bankroll
#     @name = name
#     # @hand1, @hand2, @hand3, @hand4 = [], [], [], []
#     @hands = []
#   end

#   def split(hand, bet)
#     @hands.insert(hands.index(hand) + 1,
#                   Hand.new(opening_bet, hand.cards.push!))
#   end
#   # hit groups: group 1 and group 2. Start with only cards in group 1

#   # def hands
#   #   # [@hand1, @hand2, @hand3, @hand4].select { |hand| hand }
#   # end

#   def to_s
#     @name
#   end
# end

# class Deck
#   SUITS = { :hearts => "\u2661", :diamonds => "\u2662",
#             :spades => "\u2660", :clubs => "\u2663" }
#   FACE_CARDS = { :ace => [1, 11], :king => [10],
#                  :queen => [10], :jack => [10]}
#   def initialize
#     @cards = []
#     SUITS.each do |suit|
#       FACE_CARDS.each do |card, value|
#         @cards << Card.new(card, suit, card.to_s[0].upcase, value)
#       end
#       (2..10).each do |num|
#         @cards << Card.new(num.to_s, suit, num.to_s, [num])
#       end
#     end
#   end

#   def to_a
#     @cards
#   end
# end

# class Card
#   attr_reader :suit, :type, :value, :symbol

#   def initialize(type, suit, symbol, value)
#     @suit = suit
#     @type = type
#     @value = value
#     @symbol = symbol
#   end
# end

# class Shoe
#   attr_reader :shoe

#   def initialize(num_decks)
#     @quantity = num_decks
#     @decks = []
#     (1..@quantity).each do |num|
#       @decks += Deck.new.to_a
#     end
#     @shoe = @decks.dup
#     shuffle_cards
#     place_cut_card
#   end

#   def deal_card
#     shoe.shift!
#   end

#   def shuffle_cards
#     @shoe = @decks.dup.shuffle
#     place_cut_card
#   end

#   def place_cut_card
#     @cut_card_index = (15..(shoe.size/2)).sample
#   end

#   def to_a
#     shoe
#   end

#   def [](index)
#     shoe[index]
#   end

#   def reshuffle?
#     shoe.size <= @cut_card_index
#   end
# end

# class TOGame
#   STARTING_BANKROLL = 500
#   WIN_MULTIPLIER = 1.5
#   NATURAL_MULTIPLIER = 2
#   MAX_DECKS = 8
#   MIN_DECKS = 1

#   def play
#     display_welcome_message
#     main_game
#     display_goodbye_message
#   end

#   private

#   def clear
#     system "clear"
#   end

#   def display_welcome_message
#     puts "Welcome to Twenty-One!"
#     puts ""
#   end

#   def display_goodbye_message
#     puts ""
#     # display_final_score
#     puts "Thanks for playing Twenty-One! Goodbye!"
#   end

#   def deal_hand_animation(hands)
#     hands
#     game_screen
#   end

# # How to get one line at a time
# #
#   def deal_starting_hands
#     clear_screen
#     game_screen
#     # hit(game_stuff['player']['hands'][0]['hand'], game_stuff)
#     # hit(game_stuff['dealer']['hidden_card'], game_stuff)
#     # deal_hand_animation(game_stuff)
#     # game_stuff['dealer']['hands'][0]['hand'].push({ 'card' => 'hidden',
#     #                                                 'chr' => '  ', 'value' => [0],
#     #                                                 'suit' => ' ' })
#     # deal_hand_animation(game_stuff)
#     # hit(game_stuff['player']['hands'][0]['hand'], game_stuff)
#     # deal_hand_animation(game_stuff)
#     # hit(game_stuff['dealer']['hands'][0]['hand'], game_stuff)
#     # deal_hand_animation(game_stuff)
#   end

#   def get_deck_quantity
#     num_decks = nil
#     loop do
#       puts "How many decks? (#{MIN_DECKS}-#{MAX_DECKS})"
#       num_decks = gets.chomp.to_i
#       break if num_decks === (1..8)
#       puts "Answer invalid"
#     end
#     num_decks
#   end

#   def get_name

#   end

#   def new_deal

#   end

#   def new_game
#     @num_decks = get_deck_quantity
#     @shoe = Shoe.new(@num_decks)
#     @player = Player.new(:human, get_name, STARTING_BANKROLL)
#     @dealer = Player.new(@player = Player.new(:dealer, 'Dealer')
#   end

#   def play_again?
#     answer = nil
#     loop do
#       puts "Play another hand? (y/n)"
#       answer = gets.chomp.downcase
#       break if %w(y n).include? answer
#       puts "Sorry, must be y or n"
#     end
#     answer == 'y'
#   end

#   def reset
#     @shoe = Shoe.new(@num_decks)
#   end

#   def game_screen
#   end

#   def main_game
#     loop do
#       new_game
#       loop do
#         # display_board
#         # player_move
#         # display_result
#         # update_score
#         # break if grand_winner
#         # break unless play_again?
#         # reset
#         # display_play_again_message
#       end
#     end
#   end

# end

# game = TOGame.new
# game.play
require 'pry'

SUITS = { :hearts => "\u2661", :diamonds => "\u2662",
          :spades => "\u2660", :clubs => "\u2663" }
FACE_CARDS = { :ace => [1, 11], :king => [10],
               :queen => [10], :jack => [10]}

class Actor
  def initialize
    @round_wins = 0
  end

  def new_hand

  end

  def hit(hand)
    hand.hit
  end

  # def hit?(hand)

  # end

end

class Player < Actor
  attr_reader :hands

  def initialize
    reset
  end

  def split?(hand)
    if hand.can_split?
  end

  def split(hand)

  end

  def reset
    @hands = []
  end

  def hit?

  end
end

class Dealer < Actor
  def initialize

  end

  def hit?(hand)

  end
end

class Card
  attr_reader :is_soft
  def initialize(card, suit, abbrv, val)
    if card == :ace
      @is_soft = true
      @soft_value = val[1]
      @hard_value = val[0]
    else 
      @is_soft = false
      @soft_value = val[0]
      @hard_value = val[0]
    end
    @suit = suit
    @rank = card
    @abbreviation = abbrv
  end

  def value
    @is_soft ? @soft_value : @hard_value
  end

  def harden
    @is_soft = false
  end
end

class Deck
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

  def [] (i)
    @cards[i]
  end
end

class Shoe
  attr_reader :num_decks, :discard_pile
  def initialize
    @shoe = []
    @discard_pile = []
    ask_num_decks
    @num_decks.times { @shoe += Deck.new.to_a }
  end

  def ask_num_decks
    puts "How many decks?(1-8)"
    @num_decks = gets.chomp.to_i
  end

  def shuffle
    @shoe.shuffle!
  end

  def deal_card
    @discard_pile << @shoe.shift
  end
end

class Hand
  def initialize(shoe)
    @cards = []
    @bet
    @shoe = shoe
  end

  def can_split?
    @cards.size == 2 && @cards.map { |c| c.rank }.all?(@cards[0].rank)
  end

  def soft_hand?
    @cards.any?(@cards.is_soft)
  end

  def value
    total = 0
    @cards.each do |card|
      total += card.value
    end
    if total > 21 && @cards.any? {|card| card.is_soft }
      @cards[@cards.find_index { |card| card.is_soft }].is_soft = false
      total = value
    end
    total
  end

  # def hit

  # end

  def add_card
    @cards << @shoe.deal_card
  end
end

# class GameTable
#   def initialize
#     @round_num = 1
#   end

#   def new_round

#   end

#   # use sub for string to add space if rank has 
#   def card_graphic(card_obj, r_num)
#     abbrv = card_obj.abbreviation
#     buf = abbrv.length == 1 ? ' ' : ''
#     card_graphic = ["+------+", "|#{card['chr']}#{card['suit']}#{buf}   |",
#                     "|      |", "|      |",
#                     "|   #{buf}#{card['chr']}#{card['suit']}|", "+------+"]
#     card_graphic[row_num]
#   end
# end

# # class Game

# # end

binding.pry
