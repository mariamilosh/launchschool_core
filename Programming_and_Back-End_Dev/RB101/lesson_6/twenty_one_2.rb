# Welcome to Blackjack!
# This is a graphical command line game
# The house always wins.

require 'pry'

CLEAR_CMD = 'clear'
SUITS = { 'hearts' => '<3', 'diamonds' => '<>', 'spades' => '()',
          'clubs' => '%%' }
FACE_CARDS = { 'king' => [10], 'queen' => [10], 'jack' => [10],
               'ace' => [1, 11] }
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

def clear_screen
  system(CLEAR_CMD)
end

def intro
  puts WELCOME_MESSAGE
  puts "-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-"
  puts ""
end

def lower_border
  puts ""
  puts "-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-$-"
  puts ""
end

def how_many_decks?
  intro
  loop do
    puts "How many decks? (1-8)"
    num_decks = gets.chomp.to_i
    if (1..8).any?(num_decks)
      return num_decks
    end
    puts "Answer not valid. Please enter a number 1 - 8"
  end
end

# Initialize deck
# Array of [card, {suit, symbol, chr, buf, [value]}]
# Specify number of decks
def initialize_shoe(num = 1)
  shoe = []
  num.times do
    SUITS.each do |suit, sym|
      (2..10).each do |num_card|
        if num_card == 10
          buf = ''
          shoe << [num_card.to_s, { 'suit' => suit, 'symbol' => sym,
                                    'chr' => num_card.to_s, 'buf' => buf,
                                    'value' => [num_card] }]
        else
          buf = ' '
          shoe << [num_card.to_s, { 'suit' => suit, 'symbol' => sym,
                                    'chr' => num_card.to_s, 'buf' => buf,
                                    'value' => [num_card] }]
        end
      end
      FACE_CARDS.each do |card, value|
        buf = ' '
        shoe << [card.to_s, { 'suit' => suit, 'symbol' => sym,
                              'chr' => card[0].upcase, 'buf' => buf,
                              'value' => value }]
      end
    end
  end
  return shoe
end

def deal_hand_animation(cards, name, lines, score_text, last_row = false)
  lines.times { puts "" }
  puts name
  display_hand(cards)
  puts score_text
  lower_border if last_row
end

def between_frames
  sleep [0.9, 1, 1.1].sample
  clear_screen
  intro
end

def deal_starting_hand(player_hand, dealer_hand)
  p_vspace = 5
  card_height = 7
  d_vspace = 0
  score_text = ""
  cmbn_vspace = p_vspace + card_height
  player_frames = [[[player_hand[0][0]]], [player_hand[0]]]
  dealer_frames = [[[dealer_hand[0][0]]], [dealer_hand[0]]]

  clear_screen
  intro
  puts "Dealer"
  cmbn_vspace.times { puts "" }
  puts "Player"
  card_height.times { puts "" }
  lower_border
  between_frames
  puts "Dealer"
  deal_hand_animation(player_frames[0], "Player", cmbn_vspace, score_text, true)
  between_frames
  deal_hand_animation(dealer_frames[0], "Dealer", d_vspace, score_text)
  deal_hand_animation(player_frames[0], "Player", p_vspace, score_text, true)
  between_frames
  deal_hand_animation(dealer_frames[0], "Dealer", d_vspace, score_text)
  deal_hand_animation(player_frames[1], "Player", p_vspace, score_text, true)
  between_frames
  deal_hand_animation(dealer_frames[1], "Dealer", d_vspace, score_text)
  deal_hand_animation(player_frames[1], "Player", p_vspace, score_text, true)
  sleep 1
end

def start_deal(player_hand, dealer_hand, hidden_card, shoe)
  hit(player_hand[0], shoe)
  hit(hidden_card, shoe)
  hit(player_hand[0], shoe)
  hit(dealer_hand[0], shoe)
  dealer_hand[0].unshift(['hidden', { 'suit' => ' ', 'symbol' => '  ',
                                      'chr' => ' ', 'buf' => ' ',
                                      'value' => [0] }])
  deal_starting_hand(player_hand, dealer_hand)
end

def display_hand(hands)
  c = ''
  sym = ''
  buf = ''
  6.times do |i|
    hands.each do |hand|
      hand.each do |card|
        c = card[1]['chr']
        sym = card[1]['symbol']
        buf = card[1]['buf']
        print_card_lines = [" ------ ", "|#{c}#{sym}#{buf}  |", "|      |",
                            "|      |", "|  #{buf}#{c}#{sym}|", " ------ "]
        print print_card_lines[i]
        print " "
      end
      print "   "
    end
    puts ""
  end
end

def game_screen(player_hand, dealer_hand)
  clear_screen
  intro
  puts "Dealer"
  display_hand(dealer_hand)
  dealer_hand_value = total_hand_value(dealer_hand[0])
  puts "Total: #{dealer_hand_value}"
  puts "\n\n\n\n\n"
  puts "Player"
  display_hand(player_hand)
  player_hand_totals = []

  player_hand.each_with_index do |hand, i|
    player_hand_totals << []
    player_hand_totals[i] = total_hand_value(hand)
  end

  player_hand_totals.each_with_index do |val, i|
    if val < 10
      print "Total: #{val} "
    elsif natural_blackjack?(player_hand[i])
      print "Blackjack"
    else
      print "Total: #{val}"
    end
    (player_hand[i].size * 9 + 3 - 9).times { print " " }
  end

  puts ""
  lower_border
end

def natural_blackjack?(hand)
  true if total_hand_value(hand) == 21 && hand.size == 2
end

# Find highest value of hand that does not exceed 21
def total_hand_value(hand)
  hand_values = []
  hand.each { |card| hand_values << card[1]['value'] }
  ace_values = hand_values.select { |card| card.size > 1 }
  card_values = hand_values.reject { |card| card.size > 1 }
  elevens = ace_values.size
  val_arr = []
  for ones in 0..ace_values.size do
    val_arr << elevens * 11 + ones
    elevens -= 1
  end
  val_arr.map! { |c| c + card_values.flatten.sum }

  # Return number closest to 21 but not over
  if val_arr.select { |val| val <= 21 }.max
    return val_arr.select { |val| val <= 21 }.max
  else
    return val_arr.min
  end
end

def hit(hand, shoe)
  hand.push(deal_card(shoe))
end

def deal_card(shoe)
  shoe.delete(shoe.sample) if !deck_empty?(shoe)
end

def double_aces?(hand, shoe)
  return false if shoe.size < 2
  return false if hand.size > 2

  cards = []
  hand.each { |card| cards << card[0] }
  cards.all?("ace")
end

def splittable?(hand, shoe)
  return false if shoe.size < 2
  return false if hand.size > 2
  vals = []
  hand.each do |h|
    vals << h[1]['value']
  end
  vals.uniq.size == 1
end

def split?
  loop do
    prompt("Split? (y/n)")
    answer = gets.chomp.downcase
    return true if answer == 'y'
    return false if answer == 'n'
    prompt("Invalid response")
  end
end

def player_split_choice(player_hand, dealer_hand, shoe)
  game_screen(player_hand, dealer_hand)
  if double_aces?(player_hand[0], shoe)
    display_hand(player_hand)
    split_hand!(player_hand, shoe) if split?
  elsif splittable?(player_hand[0], shoe)
    display_hand(player_hand)
    if split?
      split_hand!(player_hand, shoe)
      hand1 = player_hand[0]
      hand2 = player_hand[1]
      if splittable?(hand1, shoe)
        player_hand.delete(hand1)
        split_hand!([hand1], shoe)
        player_hand.insert(0, hand1)
      end
      if splittable?(hand2, shoe)
        hand1 = player_hand[0]
        player_hand.delete(hand1)
        split_hand!([hand1], shoe)
        player_hand.push(hand1)
      end
    end
  end
end

def split_hand!(hand, shoe)
  slice1 = hand[0].slice!(1)
  slice0 = hand[0].slice!(0)
  hand[0] << slice0
  hand << [slice1]
  hit(hand[0], shoe)
  hit(hand[1], shoe)
end

def get_turn_choice(_hand, shoe)
  if !deck_empty?(shoe)
    loop do
      prompt("Hit or stand?")
      turn = gets.chomp.downcase
      if turn == 'hit' || turn == 'h'
        return 'hit'
      elsif turn == 'stand' || turn == 's'
        return 'stand'
      end
    end
    puts "Invalid response"
  else
    return 'empty'
  end
end

def get_player_turn(player_hand, dealer_hand, shoe)
  player_split_choice(player_hand, dealer_hand, shoe)

  player_hand.each do |hand|
    loop do
      game_screen(player_hand, dealer_hand)
      display_hand([hand])
      puts "Player score: #{total_hand_value(hand)}"
      if total_hand_value(hand) < 21
        choice = get_turn_choice(hand, shoe)

        if choice == 'hit'
          hit(hand, shoe)
        end
      elsif total_hand_value(hand) > 21 || total_hand_value(hand) == 21
        break
      end

      if choice == 'empty' || choice == 'stand'
        break
      end
    end
  end
end

def dealer_turn(dealer_hand, hidden_card, player_hand, shoe)
  game_screen(player_hand, dealer_hand)
  flip(dealer_hand, hidden_card)
  sleep 0.5
  loop do
    dealer_hand_value = total_hand_value(dealer_hand[0])
    game_screen(player_hand, dealer_hand)
    break if !dealer_hit?(dealer_hand, dealer_hand_value)
    if !deck_empty?(shoe)
      hit(dealer_hand[0], shoe)
      sleep 1.5
    else
      puts "Deck out of cards. See final score:"
      break
    end
  end
end

def flip(dealer_hand, hidden_card)
  dealer_hand[0].delete(['hidden', { 'suit' => ' ', 'symbol' => '  ',
                                     'chr' => ' ', 'buf' => ' ',
                                     'value' => [0] }])
  dealer_hand[0].insert(0, hidden_card.flatten(1))
end

def dealer_hit?(dealer_hand, hand_value)
  return true if hand_value < 17
  if hand_value == 17 && dealer_hand[0].flatten.any?("ace") &&
     dealer_hand[0].size == 2
    return true
  end
  return false if hand_value >= 17
end

def deck_empty?(shoe)
  return true if shoe.size == 0
end

def four_cards_left?(shoe)
  return true if shoe.size <= 4
end

def place_cut_card(shoe)
  rand(15..(shoe.size / 2))
  # binding.pry
end

def shuffle_deck?(cut_card_index, shoe)
  shoe.size <= cut_card_index
end

def shuffling
  4.times do |i|
    clear_screen
    intro
    print "Reshuffling deck"
    i.times { print "." }
    sleep 1
  end
end

def another_hand?
  puts ""
  prompt("Another hand? (y/n)")
  answer = gets.chomp.downcase
  answer == 'y' || answer == 'yes'
end

def single_deck?(num_decks)
  num_decks == 1
end

def score_round(player_hand, dealer_hand)
  dealer_hv = total_hand_value(dealer_hand[0])
  puts "Dealer score: #{dealer_hv}"
  puts "Dealer went bust!" if dealer_hv > 21
  player_hand.each_with_index do |_, i|
    puts ""
    player_hv = total_hand_value(player_hand[i])
    display_hand([player_hand[i]])
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

loop do
  clear_screen
  num_decks = how_many_decks?
  shoe = initialize_shoe(num_decks)
  cut_card_index = place_cut_card(shoe)
  # binding.pry
  round = 1
  loop do
    player_hand = [[]]
    dealer_hand = [[]]
    hidden_card = []
    start_deal(player_hand, dealer_hand, hidden_card, shoe)
    get_player_turn(player_hand, dealer_hand, shoe)
    dealer_turn(dealer_hand, hidden_card, player_hand, shoe)
    score_round(player_hand, dealer_hand)

    if single_deck?(num_decks)
      if round == 4
        prompt("Last Round!")
      end
      if round == 5
        prompt("Game Over")
        break
      end
      break unless another_hand?
      round += 1
    elsif four_cards_left?(shoe)
      puts "Last round before shuffle"
      break unless another_hand?
    elsif shuffle_deck?(cut_card_index, shoe)
      break unless another_hand?
      shuffling
      shoe = initialize_shoe(num_decks)
      cut_card_index = place_cut_card(shoe)
    else
      break unless another_hand?
    end
  end
  prompt("Start a new game? (y/n)")
  answer = gets.chomp.downcase
  break unless answer == "y"
end
puts ""
puts "Thanks for playing! Goodbye."
