require_relative 'piece'
require_relative 'empty_square'

class Bishop < Piece
  attr_accessor :moveset, :symbol
  def initialize(color, row, col)
    super(color, row, col) #super calls a method on the parent class with the same name as the method that calls super. In this case, it will call initialize in the Piece class
    @moveset = [
      [1,   1],
      [-1, -1],
      [1,  -1],
      [-1,  1]
    ]
    @symbol = color == :white ? ' ♝ ' : ' ♗ '
  end
end