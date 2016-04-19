require_relative '../player'

class RandomPlayer < Player
  def turn(board, t)
    board.each_index.select { |i| board[i] == 0 }.shuffle.first
  end
end
