require_relative 'piece'
require_relative 'empty_square'

class Knight < Piece
  attr_accessor :moveset, :symbol
  def initialize(color, row, col)
    super(color, row, col)
    @moveset = [
      [ 2, 1],
      [ 2,-1],
      [-2, 1],
      [-2,-1],
      [ 1, 2],
      [ 1,-2],
      [-1, 2],
      [-1,-2],
    ]
    @symbol = color == :white ? ' ♞ ' : ' ♘ '
  end
  
  def all_possible_moves(positions)
    possible_moves = []
    moveset.each do |move|
      new_row = row + move[0]
      new_col = col + move[1]
      if within_bounds?(new_row, new_col) && legal_square?(new_row, new_col, positions)
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
  end
end