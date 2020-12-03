require "pry"

numbers = File.read("input.txt").split("\n").map(&:to_i)

EXPECTED_SUM = 2020

def find_result(numbers)
  numbers.each do |n1|
    numbers.each do |n2|
      return n1*n2 if n1+n2 == EXPECTED_SUM
    end
  end  
end

puts find_result(numbers)