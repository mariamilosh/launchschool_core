# Welcome to Blackjack!
# A graphical command line game
require 'pry'
MIN_BET = 5
MAX_DECKS = 8
MIN_DECKS = 1
BOUNDARY = "-$-"
WIN_MULTIPLIER = 1.5
NATURAL_MULTIPLIER = 2
BANKROLL = 500

CLEAR_CMD = 'clear'
# SUITS = { 'hearts' => "\u2661", 'diamonds' => "\u2662", 'spades' => "\u2663",
#           'clubs' => "\u2660" }
SUITS = ["\u2661", "\u2662", "\u2660", "\u2663"]
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

def clear_screen
  system(CLEAR_CMD)
end

def prompt(text)
  puts "=> #{text}"
end

def print_boundary
  22.times { print BOUNDARY }
  puts ""
end

def print_intro
  puts WELCOME_MESSAGE
  print_boundary
end

def print_lines(num)
  num.times { puts "" }
end

def print_game_screen(game_stuff)
  clear_screen
  print_intro
  print_bankroll(game_stuff['player']['bankroll'])
  print_rows('dealer', game_stuff['dealer']['hands'], true, false)
  print_lines(10)
  print_rows('player', game_stuff['player']['hands'])
  print_lines(1)
  print_boundary
  print_lines(1)
end

def print_bankroll(bankroll)
  48.times { print " " }
  puts "Bankroll: $#{bankroll}"
end

def print_rows(name, hands, are_totals = true, are_bets = true)
  puts name.capitalize
  print_hands(hands)
  print_totals_row(hands) if are_totals
  print_bet_row(hands) if are_bets
end

def print_hands(hands)
  (0..5).each do |row|
    hands.each do |hand|
      hand['hand'].each do |card|
        print card_rows(card, row).to_s
        print " "
      end
      print " "
    end
    puts ""
  end
end

def print_bet_row(hands)
  hands.each do |hand|
    text = "Bet: #{hand['bet']}"
    print text
    if hands.size > 1
      buff = (hand['hand'].size * 9) + 1 - text.length
      (1..buff).each { print " " }
    end
  end
  puts ""
end

def print_totals_row(hands)
  if natural_blackjack?(hands)
    print "blackjack"
  else
    hands.each do |hand|
      text = "Total: #{calculate_hand_total(hand)}"
      buff = (hand['hand'].size * 9) + 1 - text.length
      print text
      (1..buff).each { print " " }
    end
  end
  puts ""
end

def print_dealer_score(hand)
  print_score('Dealer', hand)
  puts "Dealer went bust!" if hand['score'] > 21
end

def print_scores(player_stuff, dealer_stuff, game_stuff)
  print_game_screen(game_stuff)
  print_dealer_score(dealer_stuff['hands'][0])
  player_stuff['hands'].each do |hand|
    puts ""
    print_hands([hand])
    print_score('Player', hand)
    print_hand_msg(hand, dealer_stuff['hands'][0])
  end
end

def print_score(name, hand)
  puts "#{name} score: #{hand['score']}"
end

def print_hand_msg(player_hand, dealer_hand)
  puts "bust!" if bust?(player_hand)
  if tie?(player_hand['score'], dealer_hand['score'])
    puts "tie"
    puts "+ $#{player_hand['bet']}"
  elsif win?(player_hand['score'], dealer_hand['score'])
    puts "win!"
    puts "+ $#{(player_hand['bet'] * WIN_MULTIPLIER).round(0)}"
  else
    puts "lose"
  end
end

def tie?(player_score, dealer_score)
  player_score == dealer_score || (player_score > 21 && dealer_score > 21)
end

def win?(player_score, dealer_score)
  (dealer_score > 21 || dealer_score < player_score) && player_score <= 21
end

def initialize_shoe(game_stuff, num_decks = 1)
  game_stuff['shoe'] = (1..num_decks).flat_map do
    initialize_num_cards + initialize_face_cards
  end
end

def initialize_game_stuff(game_stuff)
  game_stuff['player'] = { 'hands' => [{ 'hand' => [] }] }
  game_stuff['dealer'] = { 'hands' => [{ 'hand' => [] }], 'hidden_card' => [] }
end

def initialize_hands(game_stuff)
  game_stuff['player']['hands'] = [{ 'hand' => [] }]
  game_stuff['dealer'] = { 'hands' => [{ 'hand' => [] }], 'hidden_card' => [] }
end

def initialize_face_cards
  cards = []
  SUITS.each do |suit|
    cards += FACE_CARDS.map do |card, value|
      chr = card[0].upcase
      { 'card' => card, 'chr' => chr, 'value' => value, 'suit' => suit }
    end
  end
  cards
end

def initialize_num_cards
  cards = []
  SUITS.each do |suit|
    cards += (2..10).map do |card|
      card_name = card.to_s
      { 'card' => card_name, 'chr' => card_name,
        'value' => [card], 'suit' => suit }
    end
  end
  cards
end

def get_num(text, max_num, min_num)
  loop do
    prompt(text)
    num_str = gets.chomp
    num = num_str.to_i
    return num if pos_int?(num_str, num) && num >= min_num && num <= max_num
    prompt("Your answer is invalid")
    prompt("Number must be between #{min_num} and #{max_num}")
  end
end

def get_bet(hand, player_stuff)
  text = "Enter your starting bet (Whole number >= #{MIN_BET}): "
  hand['bet'] = get_num(text, player_stuff['bankroll'], MIN_BET)
  update_bankroll(player_stuff, -hand['bet'])
end

def single_deck?(num_decks)
  num_decks == 1
end

def shuffle_deck?(cut_card_index, game_stuff)
  if game_stuff['num_decks'] > 1
    game_stuff['shoe'].size <= cut_card_index
  elsif game_stuff['round'] >= 4
    true
  end
end

def double_aces?(player_hand)
  return false if player_hand.size > 2
  cards = []
  player_hand['hand'].each { |card| cards << card['card'] }
  cards.all?('ace')
end

def hit?
  loop do
    prompt("Hit or stay? (h/s)")
    answer = gets.chomp.downcase
    if !['h', 's', 'y', 'n'].include?(answer)
      prompt("Answer invalid. Try again...")
      next
    end
    return answer == 'h' || answer == 'y'
  end
end

def how_many_decks?
  puts ""
  text = "How many decks? (#{MIN_DECKS}-#{MAX_DECKS})"
  get_num(text, MAX_DECKS, MIN_DECKS)
end

def splittable?(hand, player_stuff)
  return false if hand['bet'] > player_stuff['bankroll'] ||
                  hand.size > 2 ||
                  player_stuff['hands'].size >= 4
  vals = []
  hand['hand'].each do |card|
    vals << card['value'][0]
  end
  vals.uniq.size == 1
end

def split_hand?(hand)
  print_hands([hand])
  yes_or_no?("Split hand? (y/n)")
end

def pos_int?(num_str, num)
  num_str == num.to_s && num > 0 && num.integer?
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

def another_hand?(game_stuff)
  puts ""
  if game_stuff['player']['bankroll'] >= MIN_BET
    yes_or_no?("Would you like to play another hand? (y/n)")
  else
    puts "You are out of money! Your bankroll is less than the minimum bet."
    false
  end
end

def new_game?
  yes_or_no?("Would you like to play a new game? (y/n)")
end

def natural_blackjack?(hands)
  calculate_hand_total(hands[0]) == 21 &&
    hands[0]['hand'].size == 2 &&
    hands.size == 1
end

def bust?(hand)
  calculate_hand_total(hand) > 21
end

def hit(hand, game_stuff)
  hand << deal_card(game_stuff)
end

def deal_card(game_stuff)
  game_stuff['shoe'].delete(game_stuff['shoe'].sample)
end

def place_cut_card(game_stuff)
  rand(15..(game_stuff['shoe'].size / 2))
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

def deal_starting_hands(game_stuff)
  clear_screen
  print_game_screen(game_stuff)
  hit(game_stuff['player']['hands'][0]['hand'], game_stuff)
  hit(game_stuff['dealer']['hidden_card'], game_stuff)
  deal_hand_animation(game_stuff)
  game_stuff['dealer']['hands'][0]['hand'].push({ 'card' => 'hidden',
                                                  'chr' => '  ', 'value' => [0],
                                                  'suit' => ' ' })
  deal_hand_animation(game_stuff)
  hit(game_stuff['player']['hands'][0]['hand'], game_stuff)
  deal_hand_animation(game_stuff)
  hit(game_stuff['dealer']['hands'][0]['hand'], game_stuff)
  deal_hand_animation(game_stuff)
end

def deal_hand_animation(game_stuff)
  sleep [0.9, 1, 1.1].sample
  clear_screen
  print_game_screen(game_stuff)
end

def card_rows(card, row_num)
  buf = card['chr'].length == 1 ? ' ' : ''
  card_graphic = ["+------+", "|#{card['chr']}#{card['suit']}#{buf}   |",
                  "|      |", "|      |",
                  "|   #{buf}#{card['chr']}#{card['suit']}|", "+------+"]
  card_graphic[row_num]
end

def start_game(game_stuff)
  clear_screen
  print_intro
  initialize_game_stuff(game_stuff)
  game_stuff['round'] = 1
  game_stuff['num_decks'] = how_many_decks?
  game_stuff['player']['bankroll'] = BANKROLL.dup
  initialize_shoe(game_stuff, game_stuff['num_decks'])
end

def start_deal(game_stuff)
  initialize_hands(game_stuff)
  clear_screen
  print_intro
  print_bankroll(game_stuff['player']['bankroll'])
  get_bet(game_stuff['player']['hands'][0], game_stuff['player'])
  deal_starting_hands(game_stuff)
end

def player_turn(game_stuff)
  if natural_blackjack?(game_stuff['player']['hands'])
    play_natural_hand(game_stuff)
  else
    player_split_turn(game_stuff['player'], game_stuff)
    player_hit_choice(game_stuff)
  end
end

def player_split_turn(player_hands, game_stuff)
  if double_aces?(player_hands['hands'][0]) &&
     split_hand?(player_hands['hands'][0])
    player_hands['hands'] = split_hand(player_hands['hands'][0],
                                       game_stuff['player'], game_stuff)
  elsif splittable?(player_hands['hands'][0], game_stuff['player'])
    player_split_choice(game_stuff['player'], game_stuff)
  end
end

def player_split_choice(player_stuff, game_stuff)
  if split_hand?(player_stuff['hands'][0])
    player_stuff['hands'] = split_hand(player_stuff['hands'][0],
                                       player_stuff, game_stuff)
    print_game_screen(game_stuff)
    hand1 = player_stuff['hands'][0]
    hand2 = player_stuff['hands'][1]
    if splittable?(hand1, player_stuff) && split_hand?(hand1)
      player_stuff['hands'].shift
      split_hand(hand1, player_stuff, game_stuff).reverse_each do |hand|
        player_stuff['hands'].unshift(hand)
      end
    end
    print_game_screen(game_stuff)
    if splittable?(hand2, player_stuff) && split_hand?(hand2)
      player_stuff['hands'].pop
      split_hand(hand2, player_stuff, game_stuff).reverse_each do |hand|
        player_stuff['hands'].push(hand)
      end
    end
  end
end

def player_hit_choice(game_stuff)
  game_stuff['player']['hands'].each do |hand|
    loop do
      print_game_screen(game_stuff)
      print_hands([hand])
      assign_score(hand)
      print_score('Player', hand)
      if hand['score'] < 21 && hit?
        hit(hand['hand'], game_stuff)
      else
        break
      end
    end
  end
end

def dealer_turn(game_stuff)
  print_game_screen(game_stuff)
  flip_hidden_card(game_stuff['dealer'])
  sleep 0.5
  loop do
    print_game_screen(game_stuff)
    break if !dealer_hit?(game_stuff)
    hit(game_stuff['dealer']['hands'][0]['hand'], game_stuff)
    sleep 1.5
  end
end

def dealer_hit?(game_stuff)
  dealer_hand = game_stuff['dealer']['hands'][0]
  hand_value = calculate_hand_total(dealer_hand)
  return true if hand_value < 17
  if hand_value == 17 && dealer_hand.flatten.any?('ace') &&
     dealer_hand.size == 2
    return true
  end
  return false if hand_value >= 17
end

def play_natural_hand(game_stuff)
  flip_hidden_card(game_stuff['dealer'])
  print_game_screen(game_stuff)
  bet = game_stuff['player']['hands'][0]['bet']
  if natural_blackjack?(game_stuff['dealer']['hands'])
    prompt("Sorry, you tied with the dealer, but you get to keep your bet.")
    update_bankroll(game_stuff['player'], bet)
  else
    update_bankroll(game_stuff['player'],
                    (bet * NATURAL_MULTIPLIER).round(0))
  end
end

def split_hand(hand, player_stuff, game_stuff)
  slice1 = hand['hand'].slice(1)
  slice0 = hand['hand'].slice(0)

  hands = [{ 'hand' => [slice0],
             'bet' => hand['bet'] },
           { 'hand' => [slice1],
             'bet' => hand['bet'] }]
  player_stuff['bankroll'] -= hand['bet']
  hit(hands[0]['hand'], game_stuff)
  hit(hands[1]['hand'], game_stuff)
  hands
end

def flip_hidden_card(dealer_stuff)
  hidden_card = dealer_stuff['hidden_card'][0]
  dealer_stuff['hands'][0]['hand'].delete({ 'card' => 'hidden', 'chr' => '  ',
                                            'value' => [0], 'suit' => ' ' })
  dealer_stuff['hands'][0]['hand'].insert(0, hidden_card)
end

def calculate_hand_total(hand)
  card_values = find_card_values(hand)
  ace_values = find_ace_values(hand)
  num_aces = ace_values.size / 2
  totals_set = (0..num_aces).map { |i| ace_values.slice(i...(num_aces + i)) }
  totals_set.map! { |vals| (vals + card_values.flatten).sum }
  totals_set.select { |total| total <= 21 }.max || totals_set.min
end

def find_card_values(hand)
  hand['hand'].filter_map do |card|
    card['value'] if card['value'].size == 1
  end
end

def find_ace_values(hand)
  hand['hand'].filter_map do |card|
    card['value'] if card['value'].size == 2
  end.flatten.sort
end

def score_round(player_stuff, dealer_stuff)
  dealer_score = assign_score(dealer_stuff['hands'][0])
  player_stuff['hands'].each do |hand|
    player_score = assign_score(hand)
    if (dealer_score > 21 || dealer_score < player_score) &&
       player_score <= 21
      winnings = (hand["bet"] * WIN_MULTIPLIER).round(0)
      player_stuff['bankroll'] += winnings
    elsif dealer_score == player_score
      player_stuff['bankroll'] += hand["bet"].round(0)
    end
  end
end

def assign_score(hand)
  hand['score'] = calculate_hand_total(hand)
end

def next_round(cut_card_index, game_stuff)
  if shuffle_deck?(cut_card_index, game_stuff)
    shuffling_msg
    initialize_shoe(game_stuff)
    game_stuff['round'] = 1
  else
    game_stuff['round'] += 1
  end
end

def update_bankroll(player_stuff, diff)
  player_stuff['bankroll'] += diff
end

def game_turns(game_stuff)
  player_turn(game_stuff)
  dealer_turn(game_stuff) if !natural_blackjack?(game_stuff['player']['hands'])
  score_round(game_stuff['player'], game_stuff['dealer'])
end

def main
  loop do
    game_stuff = {}
    start_game(game_stuff)
    cut_card_index = place_cut_card(game_stuff)
    loop do
      start_deal(game_stuff)
      game_turns(game_stuff)
      print_scores(game_stuff['player'], game_stuff['dealer'], game_stuff)
      break unless another_hand?(game_stuff)
      next_round(cut_card_index, game_stuff)
    end
    break unless new_game?
  end
end

main
