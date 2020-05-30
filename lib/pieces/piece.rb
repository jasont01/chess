class Piece
  attr_accessor :color, :row, :col
  def initialize(color, row, col)
    @color = color
    @row = row
    @col = col
  end

  def within_bounds?(row, col)
    row.between?(0,7) && col.between?(0,7) ? true : false
  end

  def legal_square?(row, col, positions)    #cannot move to a squre occupied by one of your own pieces
    positions[row][col].color != color ? true : false
  end

  def all_possible_moves(positions)
    possible_moves = []
    moveset.each do |move|
      temp_row = row
      temp_col = col
      loop do
        temp_row += move[0]
        temp_col += move[1]
        break if !within_bounds?(temp_row, temp_col)
        square = positions[temp_row][temp_col]
        if square.color == color  #square has same color as player and is blocked
          break
        elsif square.color.nil?    #square is empty. continue loop
          possible_moves << [temp_row][temp_col]
        else                      #square is not empty and must contain other player's piece. break loop as you can't move through piece.
          possible_moves << [temp_row][temp_col]
          break
        end
      end
    end
    possible_moves
  end
end