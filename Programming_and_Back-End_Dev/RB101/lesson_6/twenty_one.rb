# 52 card deck with 4 suits and 13 values
# Get close to 21 without going over
# Player and dealer each have two cards
# Player can see their two cards, only 1 dealer card is visible
# Dealer must hit unless they have 17 or higher
# Ace can be either 1 or 11

# Initialize deck: cards as hash with key for each suit and array of cards
#   as values.
# Initialize card values: hash with key of card and value of card face value
# Start game loop
# Deal 4 cards, 2 to dealer, 2 to player
# Randomly get cards from deck
# Add card type:values to hashes for player and dealer
# Remove cards selected from deck
# Check for 21
# Ask player hit or stay
# If hit, deal another card to player
# Reveal dealer 2nd card
# Check if dealer is at 17
# If player is winning or if dealer cards are <17, deal card to dealer
# If dealer and/or player not at 21, ask player to hit or stay

# Add aces to score last. Check for how many aces, then check each possible
#   total. The one that makes score closest to 21 without going over is used

# Option to split if both cards in hand are equal value up to two times, so
# three hands are in play

require 'pry'

SUITS = {'hearts'=>'<3', 'diamonds' => '<>', 'spades' => '()', 'clubs' => '%%' }
WELCOME_MESSAGE = <<-MSG
 $-----------------------$
   Welcome to Blackjack!
 $-----------------------$

  The goal is to reach 21 without going bust.

  Cards are worth...
  Ace: 1, 11
  King, Queen, Jack: 10
  2-10: face value

MSG

def prompt(text)
  puts "=> #{text}"
end

def initialize_deck(card_values, rem_deck)
  starting_deck = SUITS.keys.each_with_object({}) {|s, c| c[s] = card_values.keys}
  starting_deck.each do |suit, cards|
    cards.each do |card|
      rem_deck << [card, suit]
    end
  end
end

def initialize_card_values
  num_cards = (2..10).map { |n| n }
  card_values = num_cards.each_with_object({}) { |n, c| c[n] = [n] }
  card_values['ace'] = [1, 11]
  card_values['king'] = [10]
  card_values['queen'] = [10]
  card_values['jack'] = [10]
  return card_values
end

# Find highest value of hand that does not exceed 21
def get_hand_value(hand, card_values)
#  hand_values = hand.values.flatten.map {|card| card_values[card]}
  hand_values = hand.map { |card| card_values[card[0]] }
  ace_values = hand_values.select { |card| card.size > 1 }
  card_vals = hand_values.reject {|card| card.size > 1 }
  elevens = ace_values.size
  val_arr = []
  for ones in 0..ace_values.size do
    val_arr << elevens * 11 + ones
    elevens -= 1
  end
  val_arr.map! { |c| c + card_vals.flatten.sum }
# Return number closest to 21 but not over
  if val_arr.select { |val| val <= 21 }.max
    return val_arr.select { |val| val <= 21 }.max
  else
    return val_arr.min
  end
end

def get_turn(hand, deck, num)
# hand[1] split into hand[1], hand[2]
# deal cards to hand[1] and hand[2]
# hand[1]><hand[3] and or hand[2]><hand[4]
  if not deck_empty?(deck)
    loop do
      prompt("Hit or stay?")
      turn = gets.chomp.downcase
      if turn == 'hit' || turn == 'h'
        return 'hit'
      elsif turn == 'stay' || turn == 's'
        return 'stay'
      end
    end
    puts "Invalid response"
  else
    return 'empty'
  end
end

def deal_card(deck)
    deck.delete(deck.sample) if not deck_empty?(deck)
end

def deck_empty?(deck)
  deck.size == 0
end

def hit(hand, deck)
  hand << deal_card(deck)
end

def splittable?(hand, card_values, deck)
  return false if deck.size < 2
  cards = hand.each_with_object([]) { |c, v| v << card_values[c[0]] }
  cards.uniq.size == 1
end

def split?(hand, num)
  prompt("Split? (y/n)")
  choice = gets.chomp.downcase
  choice == 'y'
end

def double_aces?(hand, deck)
  return false if deck.size < 2
  hand.all?("ace")
end

def split_hand(hand, num, increment, deck)
  # p hand[num].slice(1)
  # binding.pry
  hand[num+increment] = [hand[num].slice!(num)]
  hit(hand[num], deck)
  hit(hand[num+increment], deck)
end

def display_hand(hands, card_values)
  6.times do |i|
    hands.each do |_, hand|
      hand.each do |card|
        if card[0] == 10
          buf = ''
          c = card[0].to_s
        else
          buf = ' '
          c = card[0].to_s[0].upcase
        end
        if card[1] != ' hidden'
          sym = SUITS[card[1]]
        else
          sym = '  '
        end
        print_card = [" ------ ", "|#{c}#{sym}#{buf}  |", "|      |",
                      "|      |", "|  #{buf}#{c}#{sym}|", " ------ "]
        print print_card[i]
        print " "
      end
      print "   "
    end
    puts ""
  end
end

def player_turn(player_hand, dealer_hand, card_values, rem_deck)
  player_split_hand(player_hand, dealer_hand, card_values, rem_deck)
  player_hand.each do |n, h|
    loop do
      # game_screen(dealer_hand, player_hand, card_values)
      # puts ""
      display_hand(player_hand.slice(n), card_values)
      puts "Player score: #{get_hand_value(player_hand[n], card_values)}"
      if get_hand_value(h, card_values) < 21
        choice = get_turn(h, rem_deck, n)
        if choice == 'hit'
          hit(h, rem_deck)
        end
      end
      if get_hand_value(h, card_values) > 21
        break
      elsif get_hand_value(h, card_values) == 21
        break
      end
      if choice == 'empty' || choice == 'stay'
        break
      end
    end
  end
end

def player_split_hand(player_hand, dealer_hand, card_values, rem_deck)
    # binding.pry
    if double_aces?(player_hand[0], rem_deck)
      display_hand(player_hand.slice(0), card_values)
      split_hand(player_hand, 0, 1, rem_deck) if split?(player_hand, 0)
      game_screen(dealer_hand, player_hand, card_values)
    elsif splittable?(player_hand[0], card_values, rem_deck)
      display_hand(player_hand.slice(0), card_values)
      if split?(player_hand, 0)
        split_hand(player_hand, 0, 1, rem_deck)
        game_screen(dealer_hand, player_hand, card_values)
        # binding.pry
        if splittable?(player_hand[0], card_values, rem_deck)
          puts ""
          display_hand(player_hand.slice(0), card_values)
          puts "Hand total: #{get_hand_value(player_hand[0], card_values)}"
          split_hand(player_hand, 0, 2, rem_deck) if split?(player_hand, 0)
          game_screen(dealer_hand, player_hand, card_values)
        end
        # binding.pry
        if splittable?(player_hand[1], card_values, rem_deck)
          puts ""
          display_hand(player_hand.slice(1), card_values)
          puts "Hand total: #{get_hand_value(player_hand[1], card_values)}"
          split_hand(player_hand, 1, 2, rem_deck) if split?(player_hand, 1)
          game_screen(dealer_hand, player_hand, card_values)
        end
      end
    end
end

def dealer_turn(dealer_hand, hidden_card, player_hand, rem_deck, card_values, scores)
  flip(dealer_hand, hidden_card)
  sleep 0.5
  loop do
    dealer_hand_value = get_hand_value(dealer_hand[0], card_values)
    game_screen(dealer_hand, player_hand, card_values)
    break if not dealer_hit?(dealer_hand, dealer_hand_value, scores)
    if not deck_empty?(rem_deck)
      hit(dealer_hand[0], rem_deck)
      sleep 1.5
    else
      puts "Deck out of cards. See final score:"
      break
    end
  end
end

def flip(dealer_hand, hidden_card)
  dealer_hand[0].reject! { |element| element == [" hidden", " hidden"]}
  dealer_hand[0] << hidden_card.flatten
end

def dealer_hit?(dealer_hand, hand_value, best_player_score)
  # return true if hand_value < best_player_score
  return true if hand_value < 17
  if hand_value == 17 && dealer_hand[0].flatten.any?("ace") && dealer_hand[0].size == 2
    return true
  end
  return false if hand_value >= 17
end

def game_screen(dealer_hand, player_hand, card_values)
  system("clear")
  puts WELCOME_MESSAGE
  puts "-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-"
  puts ""
  puts "Dealer"
  display_hand(dealer_hand, card_values)
  dealer_hand_value = get_hand_value(dealer_hand[0].reject {|m| m == [" hidden", " hidden"]}, card_values)
  puts "Total: #{dealer_hand_value}"
  puts "\n\n\n\n\n"
  puts "Player"
  display_hand(player_hand, card_values)
  player_hand_values = player_hand.each_with_object([]) do | (k, h), s |
    s << get_hand_value(player_hand[k], card_values)
  end

  player_hand_values.each_with_index do |val, i|
    if val < 10
      print "Total: #{val} "
    else
      print "Total: #{val}"
    end
    # binding.pry

    (player_hand[i].size * 9 + 3 - 9).times { |t| print " "}
  end
  puts ""
  puts "\n-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-"

  # player_hand_value = get_hand_value(player_hand[1], card_values)
  # puts "Player score: #{player_hand_value}"
end

def start_deal(dealer_hand, player_hand, hidden_card, rem_deck)
  hit(player_hand[0], rem_deck)
  hit(dealer_hand[0], rem_deck)
  hit(player_hand[0], rem_deck)
  hit(hidden_card, rem_deck)
  dealer_hand[0].push([" hidden", " hidden"])
end

def score_round(player_hand, dealer_hand, card_values)
  dealer_hv = get_hand_value(dealer_hand[0], card_values)
  puts ""
  puts "Dealer score: #{dealer_hv}"
  puts "Dealer went bust!" if dealer_hv > 21
  player_hand.each do |n, h|
    puts ""
    player_hv = get_hand_value(player_hand[n], card_values)
    display_hand(player_hand.slice(n), card_values)
    puts "Player score: #{player_hv}"
    if player_hv > 21
      puts "bust!"
    elsif (dealer_hv > 21 || dealer_hv < player_hv) && player_hv <= 21
      puts "win!"
    elsif dealer_hv == player_hv
      puts "tie"
    else
      puts "lose"
    end
  end
end

# Game loop
loop do
  card_values = initialize_card_values
  rem_deck = []

  initialize_deck(card_values, rem_deck)

  loop do
    player_hand = { 0 => [] }
    dealer_hand = { 0 => [] }
    hidden_card = []

    start_deal(dealer_hand, player_hand, hidden_card, rem_deck)
    game_screen(dealer_hand, player_hand, card_values)
    puts ""

    player_turn(player_hand, dealer_hand, card_values, rem_deck)

    player_scores = player_hand.each_with_object([]) do |(n, h), s|
      if get_hand_value(player_hand[n], card_values) <= 21
        s << get_hand_value(player_hand[n], card_values)
      end
    end
    player_scores << 0

    scores = player_scores.max

    dealer_turn(dealer_hand, hidden_card, player_hand, rem_deck, card_values, scores)

    score_round(player_hand, dealer_hand, card_values)

    if rem_deck.size >= 4
      puts ""
      prompt("Another hand? (y/n)")
      answer = gets.chomp.downcase
      break if answer == "n"
    else
      break
    end
  end
  puts ""
  prompt("New game? (y/n)")
  answer = gets.chomp.downcase
  break unless answer == "y"
end
puts "\n Goodbye. Thanks for playing!"


# 5 lines
# player hand each card get first pos and upcase to get card
# get sym of suit
# print by line num
# print horizontal line of number of cards

# As an array cards in order = [[ace, hearts], [king, diamonds]]
ANIMATION_1 = <<-MSG

     ##      ##
   #    #   # #
       #      #
     #        #
   #######   ###



MSG
ANIMATION_2 = <<-MSG

     **      **
   *    *   * *
       *      *
     *        *
   *******   ***



MSG
ANIMATION_3 = <<-MSG

     ..      ..
   .    .   . .
       .      .
     .        .
   .......   ...



MSG
ANIMATION_4 = <<-MSG

     $$       $$
   $    $   $ $$
      $       $$
    $         $$
   $$$$$$$   $$$$



MSG
ANIMATION_5 = <<-MSG









MSG
ANIMATION_4 = <<-MSG

     $*       *$
   *    $   * $*
      *       *$
    $         $*
   *$*$*$*   $*$*



MSG
def money_flash
  system('clear')
  puts ANIMATION_4
  sleep 0.5
  system('clear')
  puts ANIMATION_5
  sleep 0.2
  system('clear')
  puts ANIMATION_4
  sleep 0.6
  system('clear')
  puts ANIMATION_5
  sleep 0.2
  system('clear')
  puts ANIMATION_4
  sleep 0.7
end
def firework
  system('clear')
  puts ANIMATION_3
  sleep 0.2
  system('clear')
  puts ANIMATION_2
  sleep 0.3
  system('clear')
  puts ANIMATION_1
  sleep 0.8
  system('clear')
end
def twenty_one
  firework
  firework
  firework
  money_flash
end

# firework
# firework
# firework
# money_flash
