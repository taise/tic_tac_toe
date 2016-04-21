class Board < Array
  def initialize
    super(9)
    fill(0)
  end

  def to_status
    join(',')
  end

  def is_full?
    find_index(0).nil?
  end

  def print
    each_slice(3).map do |row|
      puts '-' * 12
      puts row.map {|v| symbolize(v) }.join(' | ')
    end
    puts '#' * 12
  end

  def put(position, symbol)
    self[position] = symbol
  end

  def symbolize(v)
    case v
    when 1  then '⭕ '
    when -1 then '❌ '
    else '  '
    end
  end
end
