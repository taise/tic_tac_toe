require './game'

total = 0
score_sheet = []

1000.times do |i|
  puts "\n#{i + 1} Game\n" + '=' * 12
  score = Game.new.play
  p score
  total += score
  score_sheet << score
  puts "total: #{total}"
end
