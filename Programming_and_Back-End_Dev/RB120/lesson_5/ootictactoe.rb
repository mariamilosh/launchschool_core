class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def count_marker(squares, marker)
    squares.collect(&:marker).count(marker)
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def markers
    all_markers = @squares.map { |_sqr, mkr| mkr.to_s }
    all_markers.uniq.reject { |m| m == Square::INITIAL_MARKER }
  end

  def markers_in_row(line)
    @squares.values_at(*line).collect(&:marker)
  end

  # returns winning marker or nil
  def winning_marker
    markers = @squares.map { |_sqr, mkr| mkr.to_s }.uniq.reject { |m| m == " " }
    WINNING_LINES.each do |line|
      markers.each do |mkr|
        if count_marker(@squares.values_at(*line), mkr) == 3
          return mkr
        end
      end
    end
    nil
  end

  def one_left_in_row?(rw)
    rw.one? { |sq| unmarked_keys.include?(sq) }
  end

  def two_in_a_row?(rw, mkr)
    count_marker(@squares.values_at(*rw), mkr) == 2
  end

  def next_move(best_move)
    return unmarked_keys.sample unless best_move
    best_move
  end

  def next_best_move(mkr)
    best_move = nil
    WINNING_LINES.each do |line|
      markers_in_row(line).each do |ln_mkr|
        if one_left_in_row?(line) && two_in_a_row?(line, ln_mkr)
          best_move = unmarked_keys.find { |sq| line.include?(sq) }
          return best_move if ln_mkr == mkr
        end
      end
    end
    next_move(best_move)
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :wins, :name

  def initialize
    # @type = type
    # @marker = marker
    @marker = choose_marker
    @name = set_name
    @wins = 0
  end

  # def add_win
  #   @wins += 1
  # end
  def win(winning_mkr)
    add_win if winning_mkr == marker
  end

  protected

  def add_win
    @wins += 1
  end

  def set_name; end

  def choose_marker
    'X'
  end
end

class Human < Player
  protected

  def set_name
    puts "What is your name?"
    gets.chomp
  end

  def choose_marker
    loop do
      puts "Choose a marker. (Any single character)"
      marker = gets.chomp
      return marker if marker.length == 1 && marker != ' '
      puts "Invalid marker."
    end
  end
end

class Computer < Player
  NAME_OPTIONS = ['Holly', 'Harvey', 'Johnny 5', 'Chappie', 'R2D2']

  def initialize(other_marker)
    @marker = choose_marker(other_marker)
    @name = set_name
    @wins = 0
  end

  protected

  def set_name
    NAME_OPTIONS.sample
  end

  def choose_marker(other_marker)
    case other_marker
    when 'O'
      'H'
    else
      'O'
    end
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  MOVE_ORDER = [HUMAN_MARKER, COMPUTER_MARKER]
  MAX_SCORE = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    # @human = Player.new(HUMAN_MARKER)
    # @computer = Player.new(COMPUTER_MARKER)
    @human = Human.new
    @computer = Computer.new(@human.marker)
    # @current_player = HUMAN_MARKER
    @current_player = @human.marker
    @difficulty = :easy
    @starting_player = @human.marker
  end

  def play
    clear
    display_welcome_message
    start
    display_goodbye_message
  end

  private

  def who_goes_first
    @starting_player = [@human, @computer].sample.marker
    @current_player = @starting_player
  end

  # rubocop:disable Metrics/MethodLength
  def choose_play_order
    loop do
      puts "Who goes first? You or the computer? (me / com)"
      turn_choice = gets.chomp.downcase
      if turn_choice == 'me'
        @starting_player = @human.marker
        @current_player = @starting_player
        break
      elsif turn_choice == 'com' || turn_choice == 'computer'
        @starting_player = @computer.marker
        @current_player = @starting_player
        break
      end
      puts "Invalid response."
    end
  end
  # rubocop:enable Metrics/MethodLength

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      update_score
      break if grand_winner
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def start
    set_difficulty
    who_goes_first
    main_game
  end

  def clear
    system "clear"
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe, #{human.name}!"
    puts "Your challenger is #{computer.name}."
    puts ""
  end

  def display_goodbye_message
    puts ""
    display_final_score
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def choose_difficulty
    loop do
      puts "Choose a difficulty level:"
      puts "Easy or hard? (e/h)"
      diff_level = gets.chomp.downcase
      return :easy if diff_level == 'e' || diff_level == 'easy'
      return :hard if diff_level == 'h' || diff_level == 'hard'
      puts "Invalid response."
    end
  end

  def set_difficulty
    @difficulty = choose_difficulty
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(arr)
    if arr.size > 1
      arr[0...-1].join(', ') + ", or #{arr[-1]}"
    else
      arr.join
    end
  end

  def human_moves
    square = nil
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    if @difficulty == :hard
      board[board.next_best_move(computer.marker)] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def human_turn?
    @current_player == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
    else
      computer_moves
    end
    @current_player = MOVE_ORDER.reject { |p| p == @current_player }[0]
  end

  def display_result
    clear_screen_and_display_board
    if human_won?
      puts "You won!"
    elsif computer_won?
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_final_score
    puts "Final Score"
    puts "-----------"
    puts score_message
    puts ""
    puts "You were the first to #{MAX_SCORE}!" if grand_winner == human
    puts "Computer was the first to #{MAX_SCORE}." if grand_winner == computer
    puts ""
  end

  def score_message
    "You: #{human.wins}    #{computer.name}: #{computer.wins}"
  end

  def grand_winner
    return human if human.wins >= MAX_SCORE
    return computer if computer.wins >= MAX_SCORE
  end

  def update_score
    if human_won?
      human.win(winning_marker)
    elsif computer_won?
      computer.win(winning_marker)
    end
    @winning_marker = nil
  end

  def human_won?
    winning_marker == human.marker
  end

  def computer_won?
    winning_marker == computer.marker
  end

  def winning_marker
    board.winning_marker
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset
    board.reset
    # @current_player = MOVE_ORDER[0]
    @current_player = @starting_player
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts score_message
    puts ""
  end
end

game = TTTGame.new
game.play
