require_relative 'piece'

class King < Piece
  attr_accessor :symbol, :moveset, :has_moved
  def initialize(color, row, col)
    super(color, row, col)
    @moveset = [
      [-1, -1], [-1, 0], [-1, 1],
      [ 0, -1],          [ 0, 1],
      [ 1, -1], [ 1, 0], [ 1, 1]]
    @symbol = color == :white ? ' ♚ ' : ' ♔ '
    @has_moved = false
  end

  def all_possilbe_moves(positions)
    possible_moves = []

    castling = castling_king_side_test(positions)
    possible_moves << castling unless castling.nil?
    castling = castling_queen_side_test(positions)
    possible_moves << castling unless castling.nil?

    moveset.each do |move|
      new_row, new_col = row + move[0], col + move[1]
      if within_bounds?(new_row, new_col) && legal_square?(new_row, new_col, positions)
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
  end

  def castling_king_side_test(positions)
    i = color == :white ? 7 : 0
    return if positions[i][7].class != Rook || positions[i][7].color != color
    if !has_moved && !positions[i][7].has_moved && positions[i][6].class == Empty_Square && positions[i][5].class == Empty_Square
      return [i, 6]
    end
  end

  def castling_queen_side_test(positions)
    i = color == :white ? 7 : 0
    return if positions[i][0].class != Rook || positions[i][0].color != color
    if !has_moved && !positions[i][0].has_moved && positions[i][1].class == Empty_Square && positions[i][2].class == Empty_Square && positions[i][3].class == Empty_Square
      return [i, 2]
    end
  end
end