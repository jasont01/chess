require 'yaml'
require_relative 'board'
require_relative 'pieces/rook'
require_relative 'rules'
include Legality

def start_game
  instructions 
  if gets.chomp[0].upcase == 'Y'
    board = load_game
  else
    board = Board.new
  end
  game_loop(board)
end

def game_loop(board)
  loop do
    board.to_s
    string = board.stalemate_or_checkmate(board)

    unless string == 'continue'
      puts string
      break
    end
    start_square, finish_square = [], []
    loop do
      start_square, finish_square = get_moves

      save_game(board) if [start_square].include?('save')
      break if legit_move?(board, start_square, finish_square)
      print 'Illegal move, try again'
    end
    puts
    board.set_new_position(start_square, finish_square)
    board.current_player = board.current_player == board.white_player ? board.black_player : board.white_player
  end
end

def legit_move?(board, start, finish)
  if board.legal_move?(board, start, finish) #This is a module dedicated to finding legal moves
    temp_board = Marshal.load( Marshal.dump(board)) # Only way to deep copy class. Clone only deep copies on level, not nested arrays.
    temp_board.set_new_position(start, finish)
    if !in_check?(temp_board)
      return true
    end
  end
  false
end

def get_moves
  puts
  puts "From"
  start = gets.chomp
  puts "To"
  finish = gets.chomp
  translate_input(start, finish)
end

def translate_input(start, finish)

  return start, finish if [start, finish].include?('save')
  
  col = translate_col(start[0])
  row = translate_row(start[1])
  finish_col = translate_col(finish[0])
  finish_row = translate_row(finish[1])
  return [row.to_i, col.to_i], [finish_row.to_i, finish_col.to_i] 
end

def translate_row(row)
  8-row.to_i
end

def translate_col(col)
  ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].index(col.downcase)
end

def instructions
  print '
 ____  _   _  _____ ____  ____
/   _\/ \ / \/  __// ___\/ ___\
|  /  | |_| ||  \  |    \|    \
|  \__| | | ||  /_ \___ |\___ |
\____/\_/ \_/\____\\\____/\____/'

  print "\n\nEnter yes if you want to load a previous game. If you ever wish to save your game enter save."
end
def save_game(board)
  File.open("../save/chess_save.yml", "w") {|f| f.write(board.to_yaml)}
  exit
end

def load_game
  board = begin
    YAML.load(File.open("../save/chess_save.yml"))
  rescue ArgumentError => e
    puts "Could not parse YAML: #{e.message}"
  end
  board
end