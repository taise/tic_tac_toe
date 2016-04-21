class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end

  def turn(_board, _t)
    # return int (0-8)
    NotImplementedError
  end

  def feedback(_value, _board)
    # game win/lose/even feedback
  end

  def save
  end
end
