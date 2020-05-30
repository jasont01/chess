require_relative 'piece'
require_relative 'empty_square'
class Pawn < Piece
  attr_accessor :symbol, :has_moved
  def initialize(color, row, col)
    super(color, row, col)
    @symbol = color == :white ? " ♟ " : ' ♙ '
    @moveset = color == :white ? [[-1, 0]] : [[1, 0]]
    @has_moved = false
    @first_moveset = color == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, -0]]
    @@en_passant_pawn = nil
  end
  def moveset
    if @has_moved
      @moveset
    else
      @first_moveset
    end
  end
  def Pawn.get_en_passant_pawn
    @@en_passant_pawn
  end
  def Pawn.set_en_passant_pawn(pawn)
    @@en_passant_pawn = pawn
  end
  def Pawn.en_passant_move_square(pawn)
    return if @@en_passant_pawn == nil
    [@@en_passant_pawn.row + pawn.moveset[0][0], @@en_passant_pawn.col]
  end
  def all_possible_moves(positions)
    possible_moves = pawn_legal_captures(positions)
    possible_moves << en_passant_capture(positions)
    moveset.each do |move|
      new_square = [row+move[0], col]
      break unless new_square.class != Empty_Square 
      possible_moves << [row+move[0], col]
    end
    possible_moves
  end

  def pawn_legal_captures(positions)
    opposite_color = color == :white ? :black : :white
    i = color == :white ? -1 : 1
    legal_captures = []
    left_capture = positions[row + i][col - 1]
    right_capture =  positions[row + i][col + 1]
    left_capture ||= Empty_Square.new
    right_capture ||= Empty_Square.new
    legal_captures << [row + i, col - 1] if left_capture.color == opposite_color
    legal_captures << [row + i, col + 1] if right_capture.color == opposite_color
    legal_captures
  end
  
  def en_passant_capture(positions)
    right_square = positions[row][col + 1]
    left_square = positions[row][col - 1]

    if left_square == @@en_passant_pawn
      [row + moveset[0][0], col - 1]
    elsif right_square == @@en_passant_pawn
      [row + moveset[0][0], col + 1]
    end
  end
end