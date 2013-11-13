require_relative 'board'
require_relative 'cpu'
require_relative 'player'


def negamax(player, board, depth)
  #not sure if I need a depth right now
  # maxdepth = 5

  if board.game_over? #|| depth > maxdepth
    results(board, player)
  else
    max = -9999 #this represents infinity
    # opponent = player.player_opponent#(player)
    opponent = player_opponent(player)

    children = board.possible_moves

    children.each do |move|
      # childboard = board.dup
      board.update_position(player, move)
      # childboard.update_position(player, move)
      rank = -negamax(opponent, board, depth + 1 )
      board.undo(move)

      if rank > max
        max = rank
      end
    end
    max
  end
end

def results(board, player)
  if board.winner == player 
    return 1
  elsif board.winner == player_opponent(player)
  # elsif board.winner == player.opponent
    return -1
  else
    return 0
  end
end

def player_opponent(player)
  player == "X" ? "O" : "X"
end

# cpu = Cpu.new("X")
# nes = Player.new("O")
game = Board.new

puts negamax("X", game, 1)