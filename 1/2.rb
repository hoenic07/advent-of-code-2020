require "pry"

numbers = File.read("input.txt").split("\n").map(&:to_i)

EXPECTED_SUM = 2020

def find_result(numbers)
  numbers.each do |n1|
    numbers.each do |n2|
      numbers.each do |n3|
        return n1*n2*n3 if n1+n2+n3 == EXPECTED_SUM
      end
    end
  end  
end

puts find_result(numbers)