def day(population)
    born_count = population.map!{ |fish| fish -= 1}.select{ |fish| fish === -1 }.length;
    population.map!{ |fish| fish === -1 ? 6 : fish};
    population.fill(8,population.size,born_count);
    return population;
end

def day2(population)
    #born = population.map!{ |fish| fish -= 4}.select{ |fish| fish < 0 }
    #population.map!{ |fish| fish < 0 ? fish + 6 : fish};
    #population.concat born.map{ |fish| fish+8 }
    #return population;
    total = population.length
    population.map!{ |fish| 256 - fish }
    population.each do |fish| 
        born_count = fish/7;
        total += born_count;
        population.drop(1);
        born_count.times do |index|
            if ((fish - index * 7 - 2) > 0)
                population.push(fish - index * 7 - 2)
            end
        end 
        puts total;
    end      
    return total
end

population = Array.new
File.foreach("ex6.txt") { |line| 
    line.chomp!;
    population = line.split(",").map(&:to_i);
}

puts day2(population);
#80.times do |index|
#    population = day(population);
#    puts index
#end
#puts population.length;
