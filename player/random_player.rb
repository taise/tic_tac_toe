require_relative '../player'

class RandomPlayer < Player
  def turn(board, _)
    board.each_index.select { |i| board[i] == 0 }.sample
  end
end
