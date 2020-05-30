require_relative 'piece'
class Rook < Piece
  attr_accessor :moveset, :symbol, :has_moved
  def initialize(color, row, col)
    super(color, row, col)
    @moveset = [
      [0,  1],
      [0, -1],
      [1,  0],
      [-1, 0]
    ]
    @symbol = color == :white ? ' ♜ ' : ' ♖ '
    @has_moved = false
  end
end