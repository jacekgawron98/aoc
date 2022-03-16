def setLine(array, line)
    first,second = line.split(" -> ");
    x1,y1 = first.split(",").map{ |x| x.to_i };
    x2,y2 = second.split(",").map{ |x| x.to_i };
    if x1 == x2
        ([y1,y2].min..[y1,y2].max).each_with_index do |row, i|
            index = i + [y1,y2].min
            array[index][x1] += 1
        end
    elsif y1 == y2
        copy = array[y1].map(&:clone);
        array[y1] = copy.map.with_index{ |x,i| i >= [x1,x2].min && i <= [x1,x2].max ? x+1 : x }
    else
        ys = x1 < x2 ? y1 : y2;
        yb = x1 <= x2 ? y2 : y1;
        dir = ys <= yb ? 1 : -1;

        ([x1,x2].min..[x1,x2].max).each_with_index do |row, i|
            horizontal = i + [x1,x2].min
            vertical = i*dir + ys
            array[vertical][horizontal] += 1
        end 
    end
end

size = 1000
array = Array.new(size) { Array.new(size) {0}};
width = array.flatten.max.to_s.size+2
File.foreach("ex5.txt") { |line| 
    setLine(array,line);
}
File.open("test.txt", "w+") do |f|
    array.each { |element| f.puts(element.join(" ")) }
end
puts array.flatten.select{ |x| x > 1 }.length;
