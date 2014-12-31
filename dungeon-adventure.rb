#Dungeon adventure game from Beginning Ruby, c. 6

class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  Player = Struct.new(:name,:location)

  Room = Struct.new(:reference,:name,:description,:connections)

end