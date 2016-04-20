require './game'

total = 0
N = 100000

N.times do |i|
  score, t = Game.new.play
  total += score
  puts "%05d" % (i + 1) + " | total: #{total} | #{t}手目 #{score}"
end

Game.new.players.map(&:save)
puts "勝率: #{total.to_f / N}"
