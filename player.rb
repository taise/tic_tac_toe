class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end

  def turn(board, t)
    # return int (0-8)
    NotImplementedError
  end
end
