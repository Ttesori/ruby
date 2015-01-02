# My implementation of the game Mastermind: one player creates a secret 4-color code (out of 8 available colors) and the other tries to guess it within twelve tries. After each turn, the guesser gets feedback on whether any of their guesses were exact, the right color in the wrong place or incorrect.

class Game
  attr_accessor :guess, :code,:player

  def initialize
    @guess = []
    start
  end

  #start
  def start
    puts "Welcome, player."
    choose_player
    @code = Code.new(@player)
    take_a_turn
  end

  def choose_player
    role = 0
    unless role == "1" || role == "2"
      puts "Would you like to play as the CODEMAKER[1] or CODEBREAKER[2]?"
      role = gets.chomp
    end
    puts "And your name is?"
    name = gets.chomp
    @player = Player.new(name,role.to_i)
  end

  #take a turn
  def take_a_turn
    turn = 1
    while turn <= 12
      puts "======================="
      puts "This is turn #{turn}.\nYour options are: #{@code.avail_colors}"
      get_guesses
      if !@code.check_guess(@guess) 
        puts "======================="
        puts @code.hints
      else
        end_game(true)
        return false
      end
      turn += 1
    end
    end_game(false)
  end

  def get_guesses
    num = 1
    while num <= 4
      print "Spot #{num} guess:"
      if @player.role == 2
        @guess[num-1] = gets[0].chomp.upcase
      else
        letter = @code.auto_guess(num)
        @guess[num-1] = letter
        puts letter
      end
        num += 1
    end
  end

  #end game
  def end_game(win)
    if win
      puts "You win, #{@player.name}!11!"
    else
      puts "Sorry, #{@player.name}, you lose :-("
    end
  end

end

class Code
  attr_reader :code, :guess, :hints, :found_colors, :avail_colors

  def initialize(player)
    @avail_colors = ["R","O","Y","G","B","V","K","W"]
    @guess = []
    @code = []
    @found_colors = []
    @avail_guesses = []
    if player.role == 2
      auto_create_code
    else manual_create_code
    end
  end

  def auto_create_code
    @code = @avail_colors.sample(4)
  end

  def manual_create_code
    puts "Please enter a 4-Color code using the letters:"
    puts @avail_colors.inspect
    num = 1
    while num <= 4
      print "Spot #{num} color:"
      @code[num-1] = gets[0].chomp.upcase
      num += 1
    end
  end

  def auto_guess(num)
    if num == 1
      @avail_guesses.clear
      @avail_colors.each do |color|
        @avail_guesses << color
      end
    end
    if @found_colors == []
      guesses = @avail_guesses
      letter = guesses.sample(1)
      @avail_guesses.delete(letter[0])
      return letter[0]
    else
      letter = @found_colors.sample(1)
      @found_colors.delete(letter[0])
      @avail_guesses.delete(letter[0])
      return letter[0]
    end
  end

  #check guess
  def check_guess(guess)
    @guess = guess
    if @guess == @code
      return true
    else
      @hints = generate_hints(@guess)
      @last_guess = @guess
      return false
    end
  end

  #generate hints
  def generate_hints(guess)
    right_guesses = 0
    right_colors = 0
    @found_colors = []
    guess.each_with_index do |guess,index|
      if guess == @code[index]
        right_guesses += 1
      end
      if @code.any? { |code| code == guess}
        right_colors += 1
        @found_colors << guess
      end
    end
    @last_hint = "You have #{right_guesses} correct guesses\nand #{right_colors} correct colors."
    return @last_hint
  end

end

class Player
  attr_accessor :name, :role
  
  def initialize(name,role)
    @name = name
    @role = role
     if role == 1
      puts "You are the codemaker. Prepare to create a code for the computer to guess."
    else
      puts "You have 12 turns to guess the computer's secret code. Ready?"
    end
  end


end
g = Game.new()