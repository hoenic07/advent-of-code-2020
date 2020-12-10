
input = File.read("input.txt").split("\n").map(&:to_i)
values = [0] + input.sort + [input.max+3]

def split_array_by(values,split_value)
  current_container = []
  values.each_with_object([]) do |value,containers|
    if current_container.empty?
      current_container << value
    elsif current_container.last + split_value == value
      containers << current_container
      current_container = [value]
    else
      current_container << value
    end
  end
end

def calc_combinations_rec(head, tail)
  tail.empty? ? 1 : (0..2).reduce(0) do |memo,v|
    current = tail[v]
    memo + ((current && [1,2,3].include?(current - head)) ? calc_combinations_rec(current, tail.drop(1+v)) : 0)
  end
end

result = split_array_by(values,3).map { |v| calc_combinations_rec(v.first, v.drop(1)) }.inject(:*)
puts "total count: #{result}"