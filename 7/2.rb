require "pry"

input = File.read("input.txt")

LEAF_BAG = "no other bags"

def parse_input(input)
  input.split(".\n").each_with_object({}) do |line,memo|
    current_bag, containing_bags_str = line.split(" bags contain ") 
    memo[current_bag] = if containing_bags_str == LEAF_BAG
      []
    else
      containing_bags_str.split(", ").map do |bag_str|
        count, name = bag_str.match(/([0-9]+) ([a-z ]+) bag[s]?/).captures
        [name, count.to_i]
      end
    end
  end
end

def count_rec(target_bag,bags)
  bags[target_bag].reduce(1) do |memo,(name,count)|
    memo + count * count_rec(name, bags)
  end
end

target_bag = "shiny gold"
bags = parse_input(input)
result_count = count_rec(target_bag,bags) - 1

puts result_count