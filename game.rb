require './board'
require './player/random_player'
require './player/q_player'

class Game

  attr_reader :players
  def initialize
    @board   = Board.new # 盤面は0で初期化
    @player1 = QPlayer.new(1)
    @player2 = RandomPlayer.new(-1)
    @players = [@player1, @player2]
    @result  = nil
  end

  def play
    t = 0
    loop do
      player = @players[t % 2]
      position = player.turn(@board, t)
      @board.put(position, player.symbol)
      # @board.print
      end_check
      if @result
        return @result, t
      end
      t += 1
    end
  end

  private

  CHECK_PATTERNS = [
    [0, 1, 2], # row check
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6], # line check
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8], # diagonal check
    [2, 4, 6]
  ].freeze

  def end_check
    # 縦横斜めで3つ揃っているものがないかチェックする
    # playerは盤面に(1, -1)を入れるので、3 or -3になったらゲーム終了
    CHECK_PATTERNS.each do |pattern|
      res = pattern.reduce(0) {|sum, i| sum + @board[i] }
      if res == 3
        @player1.feedback(1,  @board)
        @player2.feedback(-1, @board)
        @result = 1
      elsif res == -3
        @player2.feedback(1,  @board)
        @player1.feedback(-1, @board)
        @result = -1
      end
    end
    if @board.is_full?
      @player1.feedback(0.5, @board)
      @player2.feedback(0.5, @board)
      @result = 0
    else
      @player1.feedback(0, @board)
      @player2.feedback(0, @board)
    end
  end
end

if __FILE__ == $0
  game = Game.new
  p game.play
  game.players.map(&:save)
end
