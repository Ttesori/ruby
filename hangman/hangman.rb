require 'yaml'

class Game
  attr_accessor :player_name, :turns_left, :this_word

  def initialize
    start
  end

  def start
    puts "Welcome to Hangman!"
    choice = 0
    while choice != 1 && choice != 2
      puts "Press [1] to START A NEW GAME or [2] to LOAD A SAVED GAME."
      choice = gets.chomp.to_i
    end
    new_game if choice == 1
    load_game if choice == 2
  end

  def new_game
    get_player
    get_word
    @turns_left = 10
    take_turns
  end

  def get_player
    puts "What is your name?"
    @player_name = gets.chomp
    puts "Hey there, #{@player_name}. Get ready to play!"
  end

  def get_word
    @this_word = Word.new
  end

  def take_turns
    while @turns_left >0
      puts "==================================="
      puts "You have #{@turns_left} incorrect guesses left."
      @turns_left -= 1 if !guess_letter
      check_victory
    end
    puts "Out of turns. You lose :-("
  end

  def guess_letter
    @this_word.generate_board
    puts "You have chosen: #{@this_word.incorrect_guesses}" if @this_word.incorrect_guesses.length != 0
    print "Enter a letter to guess or 9 to save your game and quit: "
    guess = gets.chomp.downcase
    if guess == "9"
      save_game
    elsif @this_word.check_letter(guess) == false
      return false
    else
      return true
    end
  end

  def check_victory
    if @this_word.correct_guesses.all? {|letter| @this_word.correct_letters.include? letter} && @this_word.correct_letters.length == @this_word.correct_guesses.length
      end_game
    else
      return false
    end
  end

  def end_game
    puts "You win!!"
    @this_word.generate_board
    exit
  end

  def save_game
    generate_save_name
    to_save = [self,@this_word]
    save_file = YAML::dump(to_save)
    file = File.open(@save_file_name, "w")
    file.puts save_file
    file.close 
    puts "Save sucessful! Your file name is: #{@save_file_name}\n See you soon :-)"
    exit
  end

  def generate_save_name
    date = Time.new
    date = "#{date.year}#{date.month}#{date.day}"
    @save_file_name = "save/game_#{player_name}-#{date}.yaml"
  end

  def load_game
    games = get_file_list
    puts "Please enter the number of your saved file:"
    save_index = gets.chomp.to_i
    @save_file = games[save_index]
    load_objects(@save_file)
    puts "WELCOME BACK!"
    take_turns
  end

  def get_file_list
    games = Dir.entries("save").select {|game| game.include? "yaml"}
    games.each_with_index do |game,index|
      puts "[#{index}]: #{game}"
    end
    if games.length > 0 
      return games
    else
      puts "No saved games found."
      puts "================================"
      start
    end
  end

  def load_objects(save_file)
    file = File.open("save/#{save_file}", "r")
    game = YAML::load(file)
    @saved_game = game[0]
    @player_name = @saved_game.player_name
    @turns_left = @saved_game.turns_left
    @this_word = game[1]
  end

end

class Word
  attr_reader :correct_word,:correct_letters
  attr_accessor :incorrect_guesses, :correct_guesses

  def initialize
    @correct_word = choose_word
    @correct_letters = @correct_word.split("")
    @incorrect_guesses = []
    @correct_guesses = []
  end

  def choose_word
    words_array = load_dictionary
    words_array.sample(1)[0].downcase
  end

  def load_dictionary #loads all valid words
    dictionary = []
    dictionary_file = File.open("5desk.txt").readlines
    dictionary_file.each do |line|
      dictionary << line
    end
    dictionary.map! {|word| word.gsub(/\s/,'')}
    dictionary.select! {|word| word.length >= 5 && word.length <= 12}
    return dictionary
  end

  def generate_board
    space = ""
    @correct_letters.each do |letter|
      space = "["
      if @correct_guesses.include? letter
        space += letter
      else
        space += '_'
      end
      space += '] '
      print space
    end
    puts
  end

  def check_letter(letter)
    puts "-------------------------------"
    if @incorrect_guesses.include? letter
      puts ">> You already guessed #{letter}!"
      return true
    elsif @correct_letters.include? letter
      @correct_guesses << letter
      puts ">> #{letter} is correct!"
      return true
    else
      @incorrect_guesses << letter
      puts ">> Sorry, no #{letter} found!"
      return false
    end
  end



end
g = Game.new()
