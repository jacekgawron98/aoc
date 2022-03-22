def day(population)
    born_count = population.map!{ |fish| fish -= 1}.select{ |fish| fish === -1 }.length;
    population.map!{ |fish| fish === -1 ? 6 : fish};
    population.fill(8,population.size,born_count);
    return population;
end

def day2(population,size)
    days = [0,0,0,0,0,0,0,0,0]
    9.times do |i|
        days[i] = population.select{ |fish| fish == i}.length;
    end
    size.times do
        born = days.shift();
        days.push(born);
        days[6] += born;
    end    
    return days.inject(:+);
end

population = Array.new
File.foreach("ex6.txt") { |line| 
    line.chomp!;
    population = line.split(",").map(&:to_i);
}

puts day2(population,80);
puts day2(population,256);
#80.times do |index|
#    population = day(population);
#    puts index
#end
#puts population.length;
