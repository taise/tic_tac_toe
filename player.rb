class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end

  def turn(_, _)
    # return int (0-8)
    NotImplementedError
  end

  def feedback(_, _)
    # game win/lose/even feedback
  end
end
