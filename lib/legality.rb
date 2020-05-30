require_relative 'pieces/pieces.rb'

module Legality
  def legal_move?(board, start, finish) 
    return false if squares_legal?(board, start, finish) == false
    return false if in_moveset_and_unblocked?(board, start, finish) == false
    true
  end

  def in_moveset_and_unblocked?(board, start, finish)
    piece = board.positions[start[0]][start[1]]
    possible_moves = piece.all_possible_moves(board.positions)
    return true if possible_moves.include?(finish)
    false
  end
  
  
  def squares_legal?(board, start, finish)
    start_piece = board.positions[start[0]][start[1]]

    return false if start_piece.color != board.current_player && ![start, finish].flatten.all? {|i| i.between?(0, 7) }
    true
  end
end