module Rules
  def in_check?(board)
    king = board.find_king(board.current_player)

    board.positions.flatten.select { |p| p.class != Empty_Square && p.color != king.color }.each do |piece|
      if piece.all_possible_moves(board.positions).include?([king.row, king.col])
        return true
      end
    end
    false
  end

  def stalemate_or_checkmate(board)
    check = in_check?(board)
    if !legal_move_left?(board)
      return 'checkmate' if check
      'stalemate'
    else
      'continue'
    end
  end
  
  def legal_move_left?(board)
    board.positions.flatten.select { |p| p.class != Empty_Square && p.color == current_player }.each do |piece|
      piece.all_possible_moves(board.positions).reject { |p| p.nil? }.each do |move|
        temp_board = Marshal.load(Marshal.dump(board))
        temp_board.set_new_position([piece.row, piece.col], move)
        return true if !in_check?(temp_board)
      end
    end
    false
  end
end