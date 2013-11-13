require 'debugger'
require_relative 'board'
require_relative 'cpu'
require_relative 'player'

class Game
  attr_reader :game_board
  attr_accessor :turn
  
  def initialize
    @game_board = Board.new
  end

  def choose_player(mark)
    # mark == "X" ? @human = Player.new(mark) && @cpu = Cpu.new("O") : mark == "O" ? @human = Player.new(mark) && @cpu = Cpu.new("X")
    if mark == "X"
      @human = Player.new(mark)
      @cpu = Cpu.new("O")
    elsif mark == "O"
      @human = Player.new(mark)
      @cpu = Cpu.new("X")
    end

    # puts "human #{@human.mark}"
    # puts "cpu #{@cpu.mark}"
  end

  def start 
    print "\n\n"
    puts "*" * 30
    puts "WELCOME TO TIC TAC TOE"
    puts "-" * 23
    puts "X or O? What mark do you want to be?"
    mark = gets.chomp!.capitalize!
    #check_mark?(mark)
    choose_player(mark)
    puts "Thank You!"
    print "\n"
    puts "Please 'B' to begin or 'Q' to quit" 
    answer = gets.chomp!.capitalize!
    begin?(answer)
  end

  def begin?(answer)
    answer == "B" ? play_game : answer == "Q" ? endgame : no_option 
  end

  def play_game
    @turn = :cpu 
    puts "game has started"
    
    while true
    #need to implement game_over or game will never end  
      #break if game_board.game_over?
      # puts game_board.game_over?
      game_board.print_board
      puts @turn
      if @turn == :cpu
        puts "Computer is playing"
        cpu_move
      elsif @turn == :human
        puts "You are playing choose square [0-9]:"
        human_move
      end
    end

  end

  def cpu_move
    #finished here for tonight
    #note: computer keeps picking the same move over and over
    #in this case it always picks square 2
    move = @cpu.make_move(game_board)
    # debugger
    game_board.update_position(@cpu.mark, move)
    @turn = :human 
  end

  def human_move
    move = @human.make_move(game_board).to_i
    game_board.update_position(@human.mark, move)
    @turn = :cpu
  end

  def endgame
    puts "game has ended"
  end

  def no_option
    puts "I don't know that command! Let's start again.."
    start
  end

  def check_mark?(mark)
    if mark != "X" || mark != "O"
      puts "Please choose either 'X' or 'O' not #{mark}"
      start
    end
  end
end

toe = Game.new
toe.start
# puts toe.game_board.game_over?