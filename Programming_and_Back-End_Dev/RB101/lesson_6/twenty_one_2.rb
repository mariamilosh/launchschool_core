# Welcome to Blackjack!
# This is a graphical command line game
# The house always wins.

require 'pry'

# Must be an integer
MIN_BET = 5
MAX_DECKS = 8
DEFAULT_BANKROLL = 500
WIN_MULTIPLIER = 1.3
NATURAL_MULTIPLIER = 1.5

# System command for clearing command line
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
    puts "How many decks? (1-#{MAX_DECKS})"
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
        value = [num_card]
        chr = num_card.to_s
        if num_card == 10
          buf = ''
          add_card_to_shoe(shoe, num_card, suit, sym, chr, buf, value)
        else
          buf = ' '
          add_card_to_shoe(shoe, num_card, suit, sym, chr, buf, value)
        end
      end
      FACE_CARDS.each do |card, value|
        buf = ' '
        chr = card[0].upcase
        add_card_to_shoe(shoe, card, suit, sym, chr, buf, value)
      end
    end
  end
  shoe
end

def add_card_to_shoe(shoe, card, suit, sym, chr, buf, value)
  shoe << [card.to_s, { 'suit' => suit, 'symbol' => sym,
                        'chr' => chr, 'buf' => buf,
                        'value' => value }]
end

def deal_hand_animation(cards, name, lines, score_text, last_row = false)
  lines.times { puts "" }
  puts name
  display_hand(cards)
  puts score_text
  if last_row
    puts ""
    lower_border
  end
end

def between_frames(bankroll)
  sleep [0.9, 1, 1.1].sample
  clear_screen
  intro
  print_bankroll(bankroll)
end

def deal_starting_hand(player_hand, dealer_hand, bankroll)
  p_vspace = 5
  card_height = 7
  d_vspace = 0
  score_text = ""
  cmbn_vspace = p_vspace + card_height
  player_frames = [[{ "hand" => [player_hand[0]["hand"][0]] }], player_hand]
  dealer_frames = [[{ "hand" => [dealer_hand[0]["hand"][0]] }], dealer_hand]

  clear_screen
  intro
  print_bankroll(bankroll)
  puts "Dealer"
  cmbn_vspace.times { puts "" }
  puts "Player"
  card_height.times { puts "" }
  puts ""
  lower_border
  between_frames(bankroll)
  puts "Dealer"
  deal_hand_animation(player_frames[0], "Player", cmbn_vspace, score_text, true)
  between_frames(bankroll)
  deal_hand_animation(dealer_frames[0], "Dealer", d_vspace, score_text)
  deal_hand_animation(player_frames[0], "Player", p_vspace, score_text, true)
  between_frames(bankroll)
  deal_hand_animation(dealer_frames[0], "Dealer", d_vspace, score_text)
  deal_hand_animation(player_frames[1], "Player", p_vspace, score_text, true)
  between_frames(bankroll)
  deal_hand_animation(dealer_frames[1], "Dealer", d_vspace, score_text)
  deal_hand_animation(player_frames[1], "Player", p_vspace, score_text, true)
  sleep 1
end

def start_deal(player_hand, dealer_hand, hidden_card, shoe, bankroll)
  clear_screen
  intro

  print_bankroll(bankroll)
  puts ""
  if bankroll["amount"] >= MIN_BET
    opening_bet = nil
    loop do
      prompt("Enter your opening bet as a whole number. "\
             "Minimum bet is #{MIN_BET}. ")
      opening_bet = gets.chomp
      if opening_bet.to_i.to_s != opening_bet || opening_bet.to_i < MIN_BET
        puts "Invalid input. Please try again."
        puts ""
      elsif opening_bet.to_i > bankroll["amount"]
        puts "You cannot bet more than your bankroll."
        puts ""
      else
        break
      end
    end

    player_hand[0]["bet"] = opening_bet.to_i
    update_bankroll(bankroll, player_hand[0]["bet"])
    hit(player_hand[0]["hand"], shoe)
    hit(hidden_card, shoe)
    hit(player_hand[0]["hand"], shoe)
    hit(dealer_hand[0]["hand"], shoe)
    dealer_hand[0]["hand"].unshift(['hidden', { 'suit' => ' ', 'symbol' => '  ',
                                                'chr' => ' ', 'buf' => ' ',
                                                'value' => [0] }])
    deal_starting_hand(player_hand, dealer_hand, bankroll)
    true
  else
    puts "You have no money left in your bankroll!"
    false
  end
end

def display_hand(hands)
  c = ''
  sym = ''
  buf = ''
  6.times do |i|
    hands.each do |hand|
      hand["hand"].each do |card|
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

def print_bankroll(bankroll)
  50.times { print " " }
  print "Bankroll: $#{bankroll['amount']}"
  puts ""
end

def game_screen(player_hand, dealer_hand, bankroll)
  clear_screen
  intro
  print_bankroll(bankroll)
  puts "Dealer"
  display_hand(dealer_hand)
  dealer_hand_value = total_hand_value(dealer_hand[0]['hand'])
  puts "Total: #{dealer_hand_value}"
  puts "\n\n\n\n\n"
  puts "Player"
  display_hand(player_hand)
  player_hand_totals = []

  player_hand.each_with_index do |hand, i|
    player_hand_totals << []
    player_hand_totals[i] = total_hand_value(hand['hand'])
  end

  player_hand_totals.each_with_index do |val, i|
    if val < 10
      print "Total: #{val} "
    elsif natural_blackjack?(player_hand[i]['hand'])
      print "Blackjack"
    else
      print "Total: #{val}"
    end
    (player_hand[i]['hand'].size * 9 + 3 - 9).times { print " " }
  end
  puts ""

  player_hand.each_with_index do |hand, i|
    print "Bet: #{hand['bet']}"
    bet_width = hand['bet'].to_s.size
    (player_hand[i]['hand'].size * 9 + 3 - (5 + bet_width)).times { print " " }
  end

  puts ""
  lower_border
end

def natural_blackjack?(hand)
  true if total_hand_value(hand) == 21 && hand.size == 2
end

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
  # Check if the max possible value is less than 21, if so return it
  if val_arr.select { |val| val <= 21 }.max
    return val_arr.select { |val| val <= 21 }.max
  else
    val_arr.min
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
  return false if hand[0]["hand"].size > 2

  cards = []
  hand[0]["hand"].each { |card| cards << card[0] }
  cards.all?("ace")
end

def splittable?(hand, shoe)
  return false if shoe.size < 2
  return false if hand[0]["hand"].size > 2
  vals = []
  hand[0]["hand"].each do |h|
    vals << h[1]['value'][0]
  end
  vals.uniq.size == 1
end

def split?(hand)
  display_hand(hand)
  loop do
    prompt("Split? (y/n)")
    answer = gets.chomp.downcase
    return true if answer == 'y'
    return false if answer == 'n'
    prompt("Invalid response")
  end
end

def player_split_choice(player_hand, dealer_hand, shoe, bankroll)
  game_screen(player_hand, dealer_hand, bankroll)
  if double_aces?(player_hand, shoe)
    if split?(player_hand)
      split_hand!(player_hand, shoe, bankroll)
    end
  elsif splittable?(player_hand, shoe)
    if split?(player_hand)
      split_hand!(player_hand, shoe, bankroll)
      game_screen(player_hand, dealer_hand, bankroll)
      hand1 = [player_hand[0]]
      hand2 = [player_hand[1]]
      if splittable?(hand1, shoe) && split?(hand1)
        player_hand.delete(hand1[0])
        split_hand!(hand1, shoe, bankroll)
        player_hand.insert(0, hand1[0])
        player_hand.insert(1, hand1[1])
      end
      game_screen(player_hand, dealer_hand, bankroll)

      if splittable?(hand2, shoe) && split?(hand2)
        player_hand.delete(hand2[0])
        split_hand!(hand2, shoe, bankroll)
        player_hand.push(hand2[0])
        player_hand.push(hand2[1])
      end
    end
  end
end

def split_hand!(hand, shoe, bankroll)
  slice1 = hand[0]["hand"].slice!(1)
  slice0 = hand[0]["hand"].slice!(0)
  hand[0]["hand"] << slice0
  hand << { "hand" => [slice1], "bet" => hand[0]["bet"] }
  bankroll["amount"] -= hand[0]["bet"]
  hit(hand[0]["hand"], shoe)
  hit(hand[1]["hand"], shoe)
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
    'empty'
  end
end

# def double_down(bet)
#   prompt("You may add up to $#{bet} to your bet.")
#   loop do
#     prompt("Enter an amount: ")
#     amount = gets.chomp
#     if amount.to_i.to_s == amount && amount.to_i <= bet && amount.to_i >= 0 &&
#        !amount.include?(".")
#       break
#     elsif amount.include?(".")
#       prompt("You must enter a whole number.")
#     else
#       prompt("That amount is invalid.")
#     end
#   end
#   bet += amount.to_i
# end

def update_bankroll(bankroll, bet)
  bankroll["amount"] -= bet
end

def get_player_turn(player_hand, dealer_hand, shoe, bankroll)
  game_screen(player_hand, dealer_hand, bankroll)
  return true if total_hand_value(player_hand[0]['hand']) == 21
  player_split_choice(player_hand, dealer_hand, shoe, bankroll)

  player_hand.each do |hand|
    loop do
      game_screen(player_hand, dealer_hand, bankroll)
      display_hand([hand])
      puts "Player score: #{total_hand_value(hand['hand'])}"
      if total_hand_value(hand['hand']) < 21
        choice = get_turn_choice(hand, shoe)

        if choice == 'hit'
          hit(hand['hand'], shoe)
        end
      elsif total_hand_value(hand['hand']) > 21 ||
            total_hand_value(hand['hand']) == 21
        break
      end

      if choice == 'empty' || choice == 'stand'
        break
      end
    end
  end
  false
end

def dealer_turn(dealer_hand, hidden_card, player_hand, shoe, bankroll)
  game_screen(player_hand, dealer_hand, bankroll)
  flip(dealer_hand, hidden_card)
  sleep 0.5
  loop do
    dealer_hand_value = total_hand_value(dealer_hand[0]["hand"])
    game_screen(player_hand, dealer_hand, bankroll)
    break if !dealer_hit?(dealer_hand, dealer_hand_value)
    if !deck_empty?(shoe)
      hit(dealer_hand[0]["hand"], shoe)
      sleep 1.5
    else
      puts "Deck out of cards. See final score:"
      break
    end
  end
end

def flip(dealer_hand, hidden_card)
  dealer_hand[0]["hand"].delete(['hidden', { 'suit' => ' ', 'symbol' => '  ',
                                             'chr' => ' ', 'buf' => ' ',
                                             'value' => [0] }])
  dealer_hand[0]["hand"].insert(0, hidden_card.flatten(1))
end

def dealer_hit?(dealer_hand, hand_value)
  return true if hand_value < 17
  if hand_value == 17 && dealer_hand[0]["hand"].flatten.any?("ace") &&
     dealer_hand[0]["hand"].size == 2
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

def score_round(player_hand, dealer_hand, totals, bankroll)
  dealer_hv = total_hand_value(dealer_hand[0]["hand"])
  player_hand.each do |hand|
    player_hv = total_hand_value(hand["hand"])
    if (dealer_hv > 21 || dealer_hv < player_hv) && player_hv <= 21
      winnings = (hand["bet"] * WIN_MULTIPLIER).round(0)
      bankroll["amount"] += winnings
      totals['won'] += winnings - hand["bet"]
    elsif dealer_hv == player_hv
      bankroll["amount"] += hand["bet"].round(0)
    else
      totals['lost'] += hand['bet']
    end
    totals['hands'] += 1
  end
  print_scores(player_hand, dealer_hand, bankroll)
end

def print_scores(player_hand, dealer_hand, bankroll)
  game_screen(player_hand, dealer_hand, bankroll)
  dealer_hv = total_hand_value(dealer_hand[0]["hand"])
  puts "Dealer score: #{dealer_hv}"
  puts "Dealer went bust!" if dealer_hv > 21
  player_hand.each do |hand|
    puts ""
    player_hv = total_hand_value(hand["hand"])
    display_hand([hand])
    puts "Player score: #{player_hv}"
    if player_hv > 21
      puts "bust!"
    elsif (dealer_hv > 21 || dealer_hv < player_hv) && player_hv <= 21
      puts "win!"
      puts "+ $#{(hand['bet'] * WIN_MULTIPLIER).round(0)}"
    elsif dealer_hv == player_hv
      puts "tie"
    else
      puts "lose"
    end
  end
end

def print_totals(totals)
  puts "Your total winnings: $#{totals['won']}"
  puts "Your total losses: $#{totals['lost']}"
  net_total = totals['won'] - totals['lost']
  puts "Your net total: $#{net_total}"
  puts "You played #{totals['hands']} hands."
  if totals['hands'] != 0
    puts "You made an average of "\
         "$#{(net_total.to_f / totals['hands']).round(2)} per hand."
  end
end

def new_game?
  prompt("Start a new game? (y/n)")
  answer = gets.chomp.downcase
  answer == "y" || answer == "yes"
end

loop do
  clear_screen
  num_decks = how_many_decks?
  shoe = initialize_shoe(num_decks)
  cut_card_index = place_cut_card(shoe)
  bankroll = { "amount" => DEFAULT_BANKROLL.dup }
  round = 1
  totals = { 'won' => 0, 'lost' => 0, 'hands' => 0 }

  loop do
    player_hand = [{ 'hand' => [], 'bet' => 0 }]
    dealer_hand = [{ 'hand' => [] }]
    hidden_card = []

    if start_deal(player_hand, dealer_hand, hidden_card, shoe, bankroll)
      if !get_player_turn(player_hand, dealer_hand, shoe, bankroll)
        dealer_turn(dealer_hand, hidden_card, player_hand, shoe, bankroll)
        score_round(player_hand, dealer_hand, totals, bankroll)
      else
        flip(dealer_hand, hidden_card)
        game_screen(player_hand, dealer_hand, bankroll)
        if !natural_blackjack?(dealer_hand[0]["hand"])
          winnings = (player_hand[0]["bet"] * NATURAL_MULTIPLIER).round(0)
          puts "You won with a natural blackjack!"
          sleep 0.8
          puts "  + $#{winnings}"
          bankroll["amount"] += winnings
          totals['won'] += winnings - player_hand[0]["bet"]
          game_screen(player_hand, dealer_hand, bankroll)
          puts "You won with a natural blackjack!"
          puts "  + $#{winnings}"
        else
          puts "Sorry, you tied with the dealer, but you get to keep your bet."
          bankroll["amount"] += player_hand[0]["bet"]
        end
        totals['hands'] += 1
      end

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
    else
      break
    end
  end
  puts ""
  print_totals(totals)
  break unless new_game?
end
puts ""
puts "Thanks for playing! Goodbye."
