def is_lower(arr,x,y)
    n = Array.new
    x - 1 >= 0 ? n.push(arr[x-1][y]) : []
    x + 1 != arr.length ? n.push(arr[x+1][y]) : []
    y - 1 >= 0 ? n.push(arr[x][y-1]) : []
    y + 1 != arr[0].length ? n.push(arr[x][y+1]) : []
    n.filter!{ |x| x != nil}
    return n.all?{ |p| arr[x][y] < p};
end

def find_low_points(arr)
    size = arr[0].size
    data = arr.map.with_index{ |x,i| x.map.with_index { |y,j| is_lower(arr,i,j)? Hash["x" => i, "y" => j] : nil}.compact }
    return data
end

def find_basins(data, map, point)
    x = point["x"]
    y = point["y"]
    if (map[x][y] == 0 && data[x][y] != 9)
        map[x][y] = 1;
        x - 1 >= 0 ? find_basins(data,map,Hash["x" => x-1, "y" => y]) : []
        x + 1 != data.length ? find_basins(data,map,Hash["x" => x+1, "y" => y]) : []
        y - 1 >= 0 ? find_basins(data,map,Hash["x" => x, "y" => y-1]) : []
        y + 1 != data[0].length ? find_basins(data,map,Hash["x" => x, "y" => y+1]) : []
    end
    return map.flatten.select{ |x| x == 1}.inject(:+)
end

data = Array.new
File.foreach("ex9.txt") { |line| 
    line.chomp!;
    data.push(line.split("").map(&:to_i))
}

result = find_low_points(data).flatten
    .map{ |point| find_basins(data, Array.new(data.length) { Array.new(data[0].length) {0} }, point)};
puts find_low_points(data).flatten.map{ |point| data[point["x"]][point["y"]]+1}.inject(:+)
puts result.sort.reverse.first(3).inject(:*)