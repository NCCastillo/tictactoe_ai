require_relative 'board'
require_relative 'player'


class Cpu
  attr_reader :mark

  def initialize(mark)
    @mark = mark
    @scores = []
  end

  def make_move(board)
    negamax(mark, board, 1)
    @cpu_move
  end

  def negamax(mark, board, depth)
  #not sure if I need a depth right now
  # maxdepth = 5

  if board.game_over? #|| depth > maxdepth
    results(board, mark)
  else
    max = -9999 #this represents inifinity
    opponent = player_opponent(mark)

    board.possible_moves.each do |move|
      dup_board = board.dup 
      # board.update_position(mark, move)
      dup_board.update_position(mark, move)
      rank = -negamax(opponent, dup_board, depth + 1 )
      # board.undo(move)

      if rank > max
        @scores << rank
        max = rank
        @cpu_move = move if depth == 1
      end
    end
    max
  end
end

  def results(board, mark)
    if board.winner == mark
      return 1
    elsif board.winner == player_opponent(mark)
    # elsif board.winner == player.opponent
      return -1
    else
      return 0
    end
  end

  def player_opponent(mark)
    mark == "X" ? "O" : "X"
  end

end

# game = Array.new(9, " ")
# p ruby = Cpu.new("X")
# p ruby.player_opponent(ruby.mark)