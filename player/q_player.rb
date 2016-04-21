require 'yaml'
require_relative '../player'

class QPlayer < Player
  Q_YAML = './q.yml'

  def initialize(symbol)
    super
    @@q ||= read
    @ε_ = 0.2  # e-greedy chance of random exploration
    @α_ = 0.4  # learning rate
    @γ_ = 0.9  # discount factor for future rewards
    @last_board  = []
    @last_action = []
  end

  def turn(board, t)
    @last_board = board
    return @last_action = random if rand < @ε_

    qs = {}
    actions.map { |action| qs[action] = q_value(board.to_status, action) }
    max_q = qs.values.max
    @last_action = qs.collect {|action, q| action if q == max_q}.sample
  end

  def feedback(value, board)
    reward(value, board)
  end

  def save
    open(Q_YAML, 'w') do |f|
      f.write @@q.to_yaml
    end
  end

  private

  def q_value(state, action)
    q = @@q.dig(state, action)
    return q if q

    @@q[state] = {} if @@q[state].nil?
    @@q[state][action] = 0 if q.nil?
  end

  def actions(board = @last_board)
    board.each_index.select { |i| board[i] == 0 }
  end

  def random(board = @last_board)
    actions.sample
  end

  def reward(value, board)
    learn(@last_board.to_status, @last_action, value, board) if @last_action
  end

  def learn(state, action, reward, result_state)
    prev = q_value(state, action)
    max_q = actions(result_state).map {|action| q_value(result_state.to_status, action) }.max || 0
    @@q[state][action] = prev + @α_ * ((reward + @γ_ * max_q) - prev)
  end

  def read
    return YAML.load_file(Q_YAML) if File.exist? Q_YAML
    {}
  end
end
