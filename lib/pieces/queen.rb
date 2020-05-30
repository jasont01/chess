require_relative 'piece'
class Queen < Piece
  attr_accessor :moveset, :symbol
  def initialize(color, row, col)
    super(color, row, col)
    @moveset = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]]
    @symbol = color == :white ? ' ♛ ' : ' ♕ '
  end
end