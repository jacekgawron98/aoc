def find_position(arr)
    min = arr.min();
    max = arr.max();
    costs = [];
    (max-min).times do |i|
        cr_cost = arr.map{ |crab| ((i+min) - crab).abs}.inject(:+);
        costs.push(cr_cost);
    end
    return costs.min();
end

def find_position2(arr)
    min = arr.min();
    max = arr.max();
    costs = [];
    (max-min).times do |i|
        cr_cost = arr.map{ |crab| (1..((i+min) - crab).abs).sum}.inject(:+);
        costs.push(cr_cost);
    end
    return costs.min();
end

crabs = Array.new
File.foreach("ex7.txt") { |line| 
    line.chomp!;
    crabs = line.split(",").map(&:to_i);
}

puts find_position(crabs);
puts find_position2(crabs);