# Welcome to Blackjack!
# A graphical command line game

$LOAD_PATH << '.'

module Prompts
  def prompt(text)
    puts "=> #{text} "
  end

  def yes_or_no?(text)
    loop do
      prompt(text)
      answer = gets.chomp.downcase
      if ['y', 'n'].include?(answer)
        return answer == 'y'
      else
        prompt("Please answer using 'y' or 'n'.")
      end
    end
  end

  def split_hand?(hand)
    yes_or_no?("Split hand? (y/n)")
  end

  def new_game?
    yes_or_no?("Would you like to start a new game? (y/n)")
  end

  def new_round?
    yes_or_no?("Would you like to play another round? (y/n)")
  end

  def how_many_decks?(min_decks, max_decks)
    num_decks = 1
    loop do
      puts "How many decks?(#{min_decks}-#{max_decks})"
      num_decks = gets.chomp.to_i
      if (min_decks..max_decks).include?(num_decks)
        break
      else
        puts "Please enter an whole number between #{min_decks} and " \
          "#{max_decks}."
      end
    end
    num_decks
  end

  def hit_response
      yes_or_no?("Would you like to hit? (y/n)")
  end

  def bet_amount(bankroll, min_bet)
    bet = min_bet
    loop do
      print "Enter your bet: "
      bet = gets.chomp.to_i
      break if bet >= min_bet && bet <= bankroll
      puts ""
      puts "You must enter a number between #{min_bet} and #{bankroll}."
    end
    bet
  end

  def tied_with_dealer
    prompt("Sorry, you tied with the dealer, but you get to keep your bet.")
  end
  
end

module Graphic_Controls
  CLEAR_CMD = 'clear'
  BOUNDARY = "-$-"

  def clear_screen
    system(CLEAR_CMD)
  end

  def welcome_message
    <<-MSG 
    $-----------------------$
      Welcome to Blackjack!
    $-----------------------$

      The goal is to reach 21 without going bust.

      Cards are worth...
      Ace: 1, 11
      King, Queen, Jack: 10
      2-10: face value

    MSG
  end

  def print_intro(bankroll = false)
    clear_screen
    puts welcome_message
    print_boundary
    print_bankroll(bankroll) if bankroll != false
  end

  def print_boundary
    22.times { print BOUNDARY }
    puts ""
  end

  def print_lines(num)
    num.times { puts "" }
  end

  def shuffling_msg
    (1..4).each do |i|
      clear_screen
      print_intro
      puts ""
      print "Reshuffling deck"
      (1..i).each { print "." }
      sleep 1
    end
  end

  def print_bankroll(bankroll)
    text = "Bankroll: $#{bankroll}"
    (65 - text.length).times { print " " }
    puts "Bankroll: $#{bankroll}"
  end

  def print_game_screen(bankroll, round)
    clear_screen
    print_intro(bankroll)
    display_hands(round.dealer_round_hands)
    print_lines(10)
    display_hands(round.player_round_hands)
    display_bets(round.player_round_hands)
    print_lines(1)
    print_boundary
    print_lines(1)
  end

  def print_score_screen(bankroll, round)
    clear_screen
    print_intro(bankroll)
    display_hands(round.dealer_round_hands)
    print_lines(10)
    display_hands(round.player_round_hands)
    display_bets(round.player_round_hands)
    display_scores(round.player_round_hands)
    display_winnings(round.player_round_hands, round.multipliers)
    print_lines(1)
    print_boundary
    print_lines(1)
  end

  def print_screen_with_delay(bankroll, round)
    sleep [0.9, 1, 1.1].sample
    clear_screen
    print_game_screen(bankroll, round)
  end

  def display_card(card, row)
    abbrv = card.abbreviation
    buf = abbrv.length == 1 ? ' ' : ''
    card_graphic = ["+------+", "|#{abbrv}#{card.suit[1]}#{buf}   |",
                    "|      |", "|      |",
                    "|   #{buf}#{abbrv}#{card.suit[1]}|", "+------+"]
    card_graphic[row]
  end

  def display_hands(hands)
    0.upto(5) do |r|
      hands.each do |hand|
        display_hand(hand, r)
        print "  "
      end
      puts ""
    end
    display_totals(hands)
  end

  def display_totals(hands)
    hands.each do |hand|
      if hand.is_a?(Hand)
        if hand.natural?
          text = 'blackjack'
        elsif hand.bust?
          text = "Total: #{hand.value} 'bust'"
        else
          text = "Total: #{hand.value}"
        end
        buff = (hand.cards.size * 9) + 2 - text.length
        print text
        (1..buff).each { print " " }
      end
    end
    puts ""
  end

  def display_bets(hands)
    hands.each do |hand|
      text = "Bet $#{hand.bet}"
      print text
      if hands.size > 1
        buff = (hand.cards.size * 9) + 2 - text.length
        (1..buff).each { print " " }
      end
    end
    puts ""
  end

  def display_winnings(hands, multipliers)
    hands.each do |hand|
      mult_num = multipliers[hand.result]
      text = "#{mult_num < 0 ? "-" : "+"} $#{hand.bet * mult_num.abs}"
      print text
      if hands.size > 1
        buff = (hand.cards.size * 9) + 2 - text.length
        (1..buff).each { print " " }
      end
    end
    puts ""
  end

  def display_hand(hand, row)
    if hand.is_a?(Hand)
      hand.cards.each do |card|
        print display_card(card, row)
        print " "
      end
    end     
  end

  def display_scores(hands)
    hands.each do |hand|
      text = "#{hand.result.to_s.sub(/_/, ' ')}"
      print text
      if hands.size > 1
        buff = (hand.cards.size * 9) + 2 - text.length
        (1..buff).each { print " " }
      end
    end
    puts ""
  end
end

module Scoring
  WIN_MULTIPLIER = 1.5
  NATURAL_MULTIPLIER = 2
  MULTIPLIERS = { natural_win: NATURAL_MULTIPLIER, win: WIN_MULTIPLIER, 
                  lose: -1, tie: 1 }

  def natural_blackjack?(hands)
    hands[0].value == 21 &&
      hands[0].cards.size == 2 &&
      hands.size == 1
  end

  def win?(hand1, hand2)
    (hand2.value > 21 || hand2.value < hand1.value) && hand1.value <= 21
  end

  def double_aces?(hand)
    hand.cards.map(&:rank).all?(:ace)
  end

  def figure_result(player, dealer)
    player.hands.each do |hand|
      if player.natural? && !dealer.natural? 
        hand.result = :natural_win
      elsif win?(hand, dealer.hand) 
        hand.result = :win
      elsif tie?(hand, dealer.hand)
        hand.result = :tie
      else
        hand.result = :lose
      end
    end
  end

  def tie?(hand1, hand2)
    hand1.value == hand2.value || (hand1.bust? && hand2.bust?)
  end
end

class Actor
  include Scoring
  attr_reader :hands

  def initialize
    @hands = []
  end

  def new_hand(shoe, bet)
    hand = Hand.new(shoe, bet)
    @hands << hand
    hand
  end

  def hit(hand, hide: false)
    hand.hit(hide: hide)
  end

  def hit?(hand)
    can_hit(hand)
  end

  def can_hit(hand)
    hand.value < 21
  end

  def discard
    @hands = []
  end

  def natural?
    natural_blackjack?(@hands)
  end
end

class Player < Actor
  include Prompts, Graphic_Controls

  attr_reader :bankroll

  attr_writer :bankroll

  def initialize(bankroll, min_bet)
    reset
    @bankroll = bankroll
    @min_bet = min_bet
  end

  def can_split?(hand)
    @bankroll >= @min_bet && hand.can_split? && @hands.length < 4
  end

  def split?(hand)
    display_hands([hand])
    split_hand?(hand)
  end

  def split(hand)
    hand_index = @hands.find_index(hand)
    new_hand = hand.split
    @hands.insert(hand_index+1, new_hand)
    hand.hit
    new_hand.hit
    new_hand
  end

  def reset
    @hands = []
  end

  def hit?(hand)
    if super 
      display_hands([hand]) if @hands.size > 1
      hit_response
    end
  end

  def place_bet
    bet = bet_amount(@bankroll, @min_bet)
    update_bankroll(-bet)
    bet
  end

  def update_bankroll(diff)
    @bankroll += diff
  end
end

class Dealer < Actor
  attr_accessor :hand

  def initialize
    super
    @hand = @hands[0]
  end

  def hit?
    (@hand.value == 17 && @hand.cards.map(&:rank).any?(:ace) && 
     @hand.cards.size == 2) || @hand.value < 17
  end

  def hit(hide: false)
    super(@hand, hide: hide)
  end

  def new_hand(shoe)
    @hand = Hand.new(shoe, 0)
    @hands << @hand
    @hand
  end
end

class Card
  attr_reader :rank, :suit, :abbreviation, :hard_value
  attr_accessor :is_soft
  
  def initialize(rank, suit, abbrv, vals)
    if rank == :ace
      @is_soft = true
      @soft_value = vals[1]
      @hard_value = vals[0]
    else
      @is_soft = false
      @soft_value = vals[0]
      @hard_value = vals[0]
    end
    @suit = suit
    @rank = rank
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
  SUITS = { hearts: "\u2661", diamonds: "\u2662",
            spades: "\u2660", clubs: "\u2663" }
  FACE_CARDS = { ace: [1, 11], king: [10],
                queen: [10], jack: [10] }

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

  def [](i)
    @cards[i]
  end
end

class Shoe
  include Prompts, Graphic_Controls
  attr_reader :num_decks, :discard_pile

  def initialize(min_decks, max_decks)
    @num_decks = how_many_decks?(min_decks, max_decks)
    reset
    @shuffle_next = false
  end

  def shuffle
    @cards.shuffle!
  end

  def reshuffle
    shuffle
    shuffling_msg
  end

  def place_cut_card
    @cut_card_index = rand(15..@cards.size / 2)
  end

  def deal_card
    @shuffle_next = true if @cards.size <= @cut_card_index
    reset if @cards.size < 1
    card_dealt = @cards.shift
    @discard_pile << card_dealt
    card_dealt
  end

  def shuffle_next?
    @shuffle_next
  end

  def reset
    @cards = []
    @discard_pile = []
    @num_decks.times { @cards += Deck.new.to_a }
    shuffle_next? ? reshuffle : shuffle
    place_cut_card
    @shuffle_next = false
  end
end

class Hand
  attr_reader :bet, :cards
  attr_writer :natural
  attr_accessor :result

  def initialize(shoe, opening_bet)
    @cards = []
    @bet = opening_bet
    @shoe = shoe
    @natural = false
  end

  def can_split?
    @cards.size == 2 && @cards.map(&:hard_value).all?(@cards[0].hard_value)
  end

  def soft_hand?
    @cards.any?(&:is_soft)
  end

  def value
    total = 0
    @cards.each do |card|
      total += card.value
    end
    total
  end

  def natural?
    @natural
  end

  def bust?
    value > 21
  end

  # detect if hand should be hardened 
  def hit(hide: false)
    new_card = add_card
    new_card = hide_card(new_card) if hide
    adjust_values
    new_card
  end

  def hide_card(card)
    @blank_card = Card.new(' ', '  ', ' ', [0])
    @hidden_card = card
    @cards[@cards.find_index(card)] = @blank_card
  end

  def reveal_hidden
    @cards[@cards.find_index(@blank_card)] = @hidden_card
  end

  def adjust_values
    if self.value > 21 && @cards.any?(&:is_soft)
      @cards[@cards.find_index(&:is_soft)].is_soft = false
    end
  end

  # if split on aces, aces should be made soft again
  def split
    second_hand = Hand.new(@shoe, @bet)
    @cards.each{|card| card.is_soft = true if card.rank==:ace}
    second_hand.cards << cards.pop
    return second_hand
  end

  protected

  attr_writer :cards
  attr_writer :bet

  def add_card
    new_card = @shoe.deal_card
    @cards << new_card
    new_card
  end
end

class Round
  include Scoring, Prompts, Graphic_Controls

  attr_reader :player_round_hands, :dealer_round_hands, :multipliers

  def initialize(shoe, player, dealer)
    @multipliers = Scoring::MULTIPLIERS
    @player, @dealer, @shoe = player, dealer, shoe
    @player_round_hands, @dealer_round_hands = [], []
    @shoe.reset if @shoe.shuffle_next?
    deal
    player_turn
    dealer_turn
    update_score
    print_score_screen(@player.bankroll, self)
    close_out
  end

  def deal
    print_intro(@player.bankroll)
    player_hand = @player.new_hand(@shoe, @player.place_bet)
    @dealer.new_hand(@shoe)
    refresh_hands
    print_screen_with_delay(@player.bankroll, self)
    @dealer.hit(hide: true)
    print_screen_with_delay(@player.bankroll, self)
    @player.hit(player_hand)
    print_screen_with_delay(@player.bankroll, self)
    @dealer.hit
    print_screen_with_delay(@player.bankroll, self)
    @player.hit(player_hand)
    print_screen_with_delay(@player.bankroll, self)
  end

  def player_turn
    if @player.natural?
      flip_hidden_card
      print_screen_with_delay(@player.bankroll, self)
      if @dealer.natural?
        tied_with_dealer
      end
    else
      player_split_turn
      player_hit_choice
    end
  end

  def player_split_turn
    if double_aces?(@player.hands[0]) && @player.split?(@player.hands[0])
      split_and_refresh(hands[0])
    elsif split_condition(@player.hands[0])
      split_and_refresh(@player.hands[0])
      if split_condition(@player.hands[0])
        split_and_refresh(@player.hands[0])
      end
      if split_condition(@player.hands[-1])
        split_and_refresh(@player.hands[-1])
      end
    end
  end

  def split_condition(hand)
    @player.can_split?(hand) && @player.split?(hand)
  end

  # update Round hands variable to include newly created hand
  def split_and_refresh(hand)
    @player.split(hand)
    refresh_hands
    print_screen_with_delay(@player.bankroll, self)
  end

  def player_hit_choice
    @player.hands.each do |hand|
      loop do
        print_screen_with_delay(@player.bankroll, self)
        if hand.value < 21 && @player.hit?(hand)
          @player.hit(hand)
        else
          break
        end
      end
    end
  end

  def update_score
    figure_result(@player, @dealer)
    update_bankroll
  end

  def update_bankroll
    @player.hands.each do |hand|
      win_amount = hand.bet * @multipliers[hand.result]
      if win_amount < 0
        update_amount = 0 
      else
        update_amount = win_amount
      end
      @player.update_bankroll(update_amount)
    end
    @player.bankroll
  end
  
  def flip_hidden_card
    @dealer.hand.reveal_hidden
    @dealer.hand.adjust_values
    print_screen_with_delay(@player.bankroll, self)
  end

  # update Round hands variables to match player and dealer hands
  def refresh_hands
    @player_round_hands = @player.hands.map{ |hand| hand }
    @dealer_round_hands = @dealer.hands.map{ |hand| hand }
  end

  def dealer_turn
    if !@player.natural?
      print_game_screen(@player.bankroll, self)
      sleep 0.5
      flip_hidden_card
      loop do
        break if !@dealer.hit?
        @dealer.hit
        print_screen_with_delay(@player.bankroll, self)
      end
    end
  end

  # create copies of player and dealer hands within Round so they remain linked
  # to their Round once new Round starts.
  # clear out existing hands for dealer and player so they start 
  # fresh next round.
  def close_out
    refresh_hands
    @dealer.discard
    @player.discard
  end
end

class TOGame
  include Prompts, Graphic_Controls

  BANKROLL = 500
  MIN_BET = 5
  MIN_NUM_DECKS = 1
  MAX_NUM_DECKS = 8

  def play
    loop do
      new_game
      loop do
        new_round
        break unless new_round?
      end
      break unless new_game?
    end
  end

  def new_round
    @round_num += 1
    @current_round = Round.new(@shoe, @player, @dealer)
    @rounds << @current_round
  end

  def new_game
    @player = Player.new(BANKROLL, MIN_BET)
    @dealer = Dealer.new
    @round_num = 0
    @rounds = []
    @shoe = Shoe.new(MIN_NUM_DECKS, MAX_NUM_DECKS)
  end
end

game = TOGame.new
game.play
