# Game loop: Play again? End Game?
# Initialize Game board as an array
# Display Game board
# Check if 2-player or play computer
# Pick who gets first turn
# Player chooses a square
# Check if selection is already taken
# Generate computer selection
# Repeat until winner or board is full
# Winner if letter is same for index of a single row or column
# and/or diagonals

require 'pry'

CHOICE_HASH = { 'A' => 0, 'B' => 1, 'C' => 2, '1' => 0, '2' => 1, '3' => 2 }
WELCOME_MESSAGE = <<-MSG
***********************************************
*                 Tic-Tac-Toe                 *
***********************************************

Rules:
'X' goes first. Choose a square on the board.
The winner is the first to put their marks three
in a row either horizontal, vertical, or diagonal.

When all 9 squares are full, the game ends.

MSG

def display_board(game_arr)
  puts "    A     B     C"
  puts "       |     |"
  puts "1   #{game_arr[0][0]}  |  #{game_arr[1][0]}  |  #{game_arr[2][0]}"
  puts "       |     |"
  puts "  -----+-----+-----"
  puts "       |     |"
  puts "2   #{game_arr[0][1]}  |  #{game_arr[1][1]}  |  #{game_arr[2][1]}"
  puts "       |     |"
  puts "  -----+-----+-----"
  puts "       |     |"
  puts "3   #{game_arr[0][2]}  |  #{game_arr[1][2]}  |  #{game_arr[2][2]}"
  puts "       |     |"
  puts ""
end

def initialize_board
  [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
end

# Store all array indexes with a given symbol in new array and check if any
#   combinations match winning combinations
def win?(game_arr, game_sym)
  sym_pos = []
  wins = [[[0, 0], [0, 1], [0, 2]],
          [[0, 0], [1, 1], [2, 2]],
          [[0, 0], [1, 0], [2, 0]],
          [[1, 0], [1, 1], [1, 2]],
          [[2, 0], [2, 1], [2, 2]],
          [[2, 0], [1, 1], [0, 2]],
          [[0, 1], [1, 1], [2, 1]],
          [[0, 2], [1, 2], [2, 2]]]
  [0, 1, 2].each do |x|
    [0, 1, 2].each do |y|
      if game_arr[x][y] == game_sym
        sym_pos << [x, y]
      end
    end
  end

  wins.each do |win|
    return true if sym_pos & win == win
  end
  false
end

# Check if there are any remaining empty squares
def full_board?(game_arr)
  game_arr.flatten.none?(" ") == true
end

# Accept player/computer turn choice and store their symbol in game array
def update_board(game_arr, game_turn, game_sym)
  game_arr[CHOICE_HASH[game_turn[0].upcase]][CHOICE_HASH[game_turn[1]]] =
    game_sym
end

# Check if there is already a symbol in player/computer turn choice square
def available_square?(game_arr, game_turn)
  game_arr[CHOICE_HASH[game_turn[0].upcase]][CHOICE_HASH[game_turn[1]]] == " "
end

def win_message(winner_hsh)
  "#{winner_hsh['name']} wins!"
end

# Player 1 chooses heads or tails to decide who goes first
def who_goes_first(player1_hsh, player2_hsh)
  coin_flip_choice = ""
  puts "We'll decide who goes first with a coin toss."
  loop do
    puts "Player 1 chooses heads or tails. Winner goes first:"
    coin_flip_choice = gets.chomp.downcase
    if ['heads', 'tails'].any?(coin_flip_choice)
      break
    else
      puts "Invalid input. Please try again."
    end
  end
  coin_flip_result = ['heads', 'tails'].sample
  print "Getting coin toss result"
  sleep 0.5
  print "."
  sleep 0.5
  print "."
  sleep 0.5
  puts ".\n"
  sleep 0.5

  puts "Coin toss result: #{coin_flip_result}\n\n"
  if coin_flip_choice == coin_flip_result
    puts "Player 1 goes first! Player 1 symbol is 'X'."
    if player2_hsh["type"] != "computer"
      puts "Player 2 goes second. Player 2 symbol is 'O'."
    end
    player1_hsh["turn"] = "first"
    player1_hsh['sym'] = "X"
    player2_hsh["turn"] = "second"
    player2_hsh['sym'] = "O"
  else
    if player2_hsh["type"] == "computer"
      puts "The computer goes first. Your symbol is 'O'."
    else
      puts "Player 2 goes first! Player 2 is 'X', Player 1 is 'O'."
    end
    player1_hsh["turn"] = "second"
    player1_hsh['sym'] = "O"
    player2_hsh["turn"] = "first"
    player2_hsh['sym'] = "X"
  end
end

# Determine if Player 2 will be a person or computer
def player_or_computer?
  puts "Hello Player 1."
  loop do
    puts "Are there one or two players?"
    num = gets.chomp.downcase
    if num == "1" || num == "one" || num == "single"
      puts "You have chosen single player."
      return "computer"
    elsif num == "2" || num == "two" || num == "multiplayer"
      puts "You have chosen multiplayer."
      return "player"
    else
      puts "Invalid input. Please try again."
    end
  end
end

# Check if turn is for player or computer and run respective methods to get turn
def get_turn(player_hsh, game_arr)
  if player_hsh["type"] == "computer"
    get_computer_turn(game_arr)
  else
    get_player_turn(player_hsh, game_arr)
  end
end

# Get a turn choice from a human player
def get_player_turn(player_hsh, game_arr)
  player_turn = ""
  loop do
    puts "#{player_hsh['name']} [ '#{player_hsh['sym']}' ], " \
         "choose a square (e.g. A1)"
    player_turn = gets.chomp.chars.sort { |a, b| b <=> a }
    break if available_square?(game_arr, player_turn)
    puts "Sorry, that square is unavailable."
  end
  player_turn
end

# Get a random turn from computer
def get_computer_turn(game_arr)
  loop do
    letter_hash = { 'A' => 0, 'B' => 1, 'C' => 2 }
    sel_letter = game_arr.index(game_arr.sample)
    sel_num = game_arr[sel_letter].index(game_arr[sel_letter].sample)
    if game_arr[sel_letter][sel_num] == " "
      sleep 1
      puts "The Computer chose: #{letter_hash.key(sel_letter)}#{sel_num + 1}"
      return [letter_hash.key(sel_letter), (sel_num + 1).to_s]
    end
  end
end

# Game loop
player1_hsh = { 'name' => "Player 1", 'score' => 0 }
player2_hsh = { 'name' => "Player 2", 'score' => 0 }
loop do
  puts WELCOME_MESSAGE
  game_arr = initialize_board
  player1_hsh["type"] = "player"
  player2_hsh["type"] = player_or_computer?
  who_goes_first(player1_hsh, player2_hsh)
  first_player = player1_hsh["turn"] == "first" ? player1_hsh : player2_hsh
  second_player = first_player == player1_hsh ? player2_hsh : player1_hsh

  display_board(game_arr)
  loop do
    update_board(game_arr, get_turn(first_player, game_arr),
                 first_player['sym'])
    display_board(game_arr)
    if win?(game_arr, first_player['sym'])
      puts win_message(first_player)
      break
    end
    if full_board?(game_arr)
      puts "No moves remaining. The board is full"
      break
    end
    update_board(game_arr, get_turn(second_player, game_arr),
                 second_player['sym'])
    display_board(game_arr)
    if win?(game_arr, second_player['sym'])
      puts win_message(second_player)
      break
    end
    if full_board?(game_arr)
      puts "The board is full. There are no remaining moves."
      break
    end
  end

  puts "Play again? (y/n)"
  break if gets.chomp.downcase == "n"
end
puts "Thanks for playing! \nGoodbye."
