class Array
  def to_marubatsu
    self.map do |v|
      case v
      when 1  then '⭕ '
      when -1 then '❌ '
      else '  '
      end
    end
  end
end