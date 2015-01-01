class Game
  attr_accessor :player_x,:player_o,:board
  @@seperator = "==================="

  def initialize
    start 
  end

  def start #Begin game
    puts @@seperator
    puts "Welcome to Tic-Tac-Toe!"
    puts @@seperator
    welcome_players
    @board = Board.new()
    take_turns
  end

  def welcome_players #Set up player info
    puts "Player X is up first. What is your name?"
    @player_x = Player.new(gets.chomp,"X")
    puts @@seperator
    puts "Player O is up next. What is your name?"
    @player_o = Player.new(gets.chomp,"O")
    puts @@seperator
    puts "Welcome, #{@player_x.name} and #{@player_o.name}! Let's play!"
  end

  def take_turns
    turn = @player_x #Who goes first?
    while !victory? #While there isn't a winner...
      puts @@seperator
      @board.print_board 
      make_a_move(turn)
      turn = toggle_turn(turn) 
    end
  end

  def toggle_turn(turn)
    turn == @player_x ? turn = @player_o : turn = @player_x
    return turn
  end

  def make_a_move(turn)
    puts "#{turn.name}, what space do you want to claim for #{turn.game_piece}?"
    print "I want space #: "
    while !@board.set_a_space(gets.chomp,turn) #if the player enters an invalid space
      puts "Invalid space. Try again."
      print "I want space #: "
    end
  end

  #Check the conditions for victory
  def victory?
    if @board.check_victory == "xwin" # If X wins
      end_game(@player_x.name)
      return true
    elsif @board.check_victory == "owin" #If O wins
      end_game(@player_o.name)
      return true
    elsif @board.check_victory == "nowin" #If no one wins
      end_game("nowin")
      return true
    else
      return false
    end
  end

  def end_game(winner) #When the game is finished...
    puts @@seperator
    if winner == "nowin"
      puts "Cat's Game -- No Winner!"
    else
      puts "We have a winner -- #{winner}!"
    end
    @board.print_board
    puts @@seperator
    puts "Thanks for playing!"
    puts @@seperator
  end

end

class Board
  attr_accessor :board

  def initialize
    setup_board
  end

  def setup_board #Create the game board
    @board = []
    9.times do
      @board << "="
    end
  end

  def print_board #Display the current board
    @board.each_with_index do |space,index|
      if space == "=" 
        print "[ #{index} ]"
      else 
        print "[ #{space} ]"
      end
      puts if index == 2 || index == 5 || index == 8 #New line every 3 spaces
    end
  end

  def set_a_space(index,player) #Claim a space
    if @board[index.to_i] == "="
      @board[index.to_i] = player.game_piece
    else
      return false
    end
  end

  def check_victory #Alllll of the ways victory can happen...
    x_wins = "xwin"
    o_wins = "owin"
    n_win = "nowin"
    if [@board[0],@board[1],@board[2]].all? {|space| space == "X"}
      return x_wins
    elsif [@board[3],@board[4],@board[5]].all? {|space| space == "X"}
      return x_wins
    elsif [@board[6],@board[7],@board[8]].all? {|space| space == "X"}
      return x_wins
    elsif [@board[0],@board[3],@board[6]].all? {|space| space == "X"}
      return x_wins
    elsif [@board[1],@board[4],@board[7]].all? {|space| space == "X"}
      return x_wins
    elsif [@board[2],@board[5],@board[8]].all? {|space| space == "X"}
      return x_wins
    elsif [@board[0],@board[4],@board[8]].all? {|space| space == "X"}
      return x_wins

    elsif [@board[3],@board[4],@board[5]].all? {|space| space == "O"}
      return o_wins
    elsif [@board[6],@board[7],@board[8]].all? {|space| space == "O"}
      return o_wins
    elsif [@board[0],@board[3],@board[6]].all? {|space| space == "O"}
      return o_wins
    elsif [@board[1],@board[4],@board[7]].all? {|space| space == "O"}
      return o_wins
    elsif [@board[2],@board[5],@board[8]].all? {|space| space == "O"}
      return o_wins
    elsif [@board[0],@board[4],@board[8]].all? {|space| space == "O"}
      return o_wins
    elsif @board.all? { |space| space != "="}
      return n_win
    else 
      return false
    end
  end

end

class Player
  attr_accessor :name,:game_piece

  def initialize(name="Player",game_piece)
    @name = name
    @game_piece = game_piece
  end
end

game = Game.new()