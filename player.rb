require_relative 'board'

class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
  
  #might not need this.
  #see ai for opponent method
  def player_opponent
    @mark == "X" ? "O" : "X"
  end

  def make_move(board)
    gets.chomp!
  end
end


# nestor = Player.new("X")
# puts "Your mark: #{nestor.mark}"
# puts "Your opponent mark: #{nestor.player_opponent}"
