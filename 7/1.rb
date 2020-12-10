require "pry"

input = File.read("example.txt")

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

def contains?(current_bag, target_bag,bags)
  bags[current_bag].any? do |name,_|
    name == target_bag || contains?(name, target_bag, bags)
  end
end

target_bag = "shiny gold"
bags = parse_input(input)
result_count = bags.count { |name,_| contains?(name, target_bag,bags) }

puts result_count