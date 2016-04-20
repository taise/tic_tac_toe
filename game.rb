require './array'
require './player/random_player'
require './player/q_player'

class Game
  def initialize
    @board    = Array.new(9).fill(0) # 盤面は0で初期化
    @player1  = QPlayer.new(1)
    @player2  = RandomPlayer.new(-1)
    @playsers = [@player1, @player2]
  end

  def play
    t = 0
    until end_check
      puts "\n#{t + 1}手目"
      player = @playsers[t % 2]
      position = player.turn(@board, t)
      @board[position] = player.symbol
      # print_board
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

  def board_is_full?
    @board.find_index(0).nil?
  end

  def end_check
    # 縦横斜めで3つ揃っているものがないかチェックする
    # playerは盤面に(1, -1)を入れるので、3 or -3になったらゲーム終了
    CHECK_PATTERNS.each do |pattern|
      res = pattern.reduce(0) {|sum, i| sum + @board[i] }
      if res == 3
        @player1.feedback(1,  @board)
        @player2.feedback(-1, @board)
        return true
      end
      if res == -3
        @player2.feedback(1,  @board)
        @player1.feedback(-1, @board)
        return true
      end
    end
    if board_is_full?
      @player1.feedback(0.5, @board)
      @player2.feedback(0.5, @board)
      return true
    end
    false
  end

  def print_board
    @board.each_slice(3).each do |row|
      puts '-' * 12
      puts row.to_marubatsu.join(' | ')
    end
  end
end


50000.times do |i|
  puts "\n#{i + 1} Game\n" + '=' * 12
  Game.new.play
end
