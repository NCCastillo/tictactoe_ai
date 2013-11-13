require_relative 'cpu'
require_relative 'player'

class Board
  attr_reader :possible_squares, :winning_squares, :winner
  attr_accessor :grid

  def initialize
    @grid = grid_initialize
    @possible_squares = possible_moves
    @winning_squares = winning_positions
  end

  def grid_initialize
    Array.new(9, " ")
  end

  def game_over?
    #game is over when there is a match in row, col or diag
    #or no more squares to play
    check_for_win? || possible_moves_empty?
  end

  def check_for_win?
    #check whether there is a match in the row, col or diag
    win = false
    #need to change "X" to player.mark
    grid_match = @grid.each_index.select{ |index| @grid[index] == "X" }

    @winning_squares.each do |positions|
      win = true if positions == grid_match
      @winner = @grid[positions[0]]
    end
    win
  end

  def possible_moves
    #will give all the squares that have not been filled
    empty_squares = []
    
    @grid.each_with_index do |square, index|
        empty_squares << index if square == " "
    end
    empty_squares
  end

  def remove_possible(position)
    @possible_squares.delete(position)
  end

  def possible_moves_empty?
    @possible_squares.empty?
  end

  def update_position(mark, position)
    #this will place an X or O into an empty square
    @grid[position] = mark
    remove_possible(position)
    # print_board #this is here for testing
  end

  # def winner
  #   @winner
  # end

  def undo(move)
    @grid.delete_at(move)
  end

  def winning_positions
    positions = []

    winningrows.each { |row| positions << row }
    winningcolmuns.each { |col| positions << col }
    winningdiags.each { |diag| positions << diag }

    positions
  end

  def winningrows
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
    ]
  end

  def winningcolmuns
    rows = winningrows
    rows.transpose
  end

  def winningdiags
    [
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def print_board
    print "\n\n"
    print " #{@grid[0]} |"
    print " #{@grid[1]} |"
    print " #{@grid[2]}"
    print "\n---+---+---\n"
    print " #{@grid[3]} |"
    print " #{@grid[4]} |"
    print " #{@grid[5]}"
    print "\n---+---+---\n"
    print " #{@grid[6]} |"
    print " #{@grid[7]} |"
    print " #{@grid[8]}"
    print "\n\n"
  end

  def display_choices 
    print "\n\n"
    print "0 |"
    print "1 |"
    print "2"
    print "\n--+--+--\n"
    print "3 |"
    print "4 |"
    print "5 "
    print "\n--+--+--\n"
    print "6 |"
    print "7 |"
    print "8"
    print "\n\n"
  end

end

# test = Board.new
# test.possible_moves

# # game_over? should be true because there are no empty squares left
# # game is draw.
# test.update_position("O", 0)
# test.update_position("X", 1)
# test.update_position("O", 2)
# test.update_position("X", 3)
# test.update_position("O", 4)
# test.update_position("X", 5)
# test.update_position("O", 6)
# test.update_position("O", 7)
# test.update_position("X", 8)
# puts test.game_over?

# game_over? should be true because there are 3 x's
# test.update_position("X", 4)
# puts test.game_over?
# test.update_position("O", 1)
# puts test.game_over?
# test.update_position("X", 0)
# puts test.game_over?
# test.update_position("O", 6)
# puts test.game_over?
# test.update_position("X", 8)
# puts test.game_over?
# puts test.winner  
