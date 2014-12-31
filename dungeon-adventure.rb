#Dungeon adventure game from Beginning Ruby, c. 6

class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    puts "Welcome, #{@player.name}\n"
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
    where_to_go?
  end

  def show_current_description
    puts "=================="
    puts find_room_in_dungeon(@player.location).full_description
    puts "=================="
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference}
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def find_connections_to_room()
    connections = []
    find_room_in_dungeon(@player.location).connections.each {|key,value| connections << key.downcase}
    return connections
  end

  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
    where_to_go?
  end

  def where_to_go?
    available_moves = find_connections_to_room
    direction = nil
    while !available_moves.any? {|move| move.to_s == direction}
      print "\nWhere would you like to go? Available directions: "
      available_moves.each {|direction| puts direction.to_s}
      direction = gets.chomp.downcase
    end
    go(direction.to_sym)
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end

  class Room
    attr_accessor :reference,:name,:description,:connections

    def initialize(reference,name,description,connections)
      @reference= reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end

end

#Create the main dungeon object
my_dungeon = Dungeon.new("Ty Slayer")

#Add rooms to the dungeon
my_dungeon.add_room(:largecave,"Large Cave","a large cavernous cave",{:west => :smallcave})
my_dungeon.add_room(:smallcave,"Small Cave","a small, claustrophobic cave", {:east => :largecave})

#Start the dungeon by placing the player inthe large cave
my_dungeon.start(:largecave)