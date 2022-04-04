def count_simple(data) 
    return data.select{ |digit| (digit.length == 2 || digit.length == 3 || digit.length == 4 || digit.length == 7) }.length
end

def check_if_contains(mask1,mask2)
    if mask1 == "" || mask2 == ""
        return false
    end
    return (mask1.split("") & mask2.split("")).size == mask2.split("").size ? true : false
end

def get_dif(seq1, seq2)
    return (seq1.split("")-seq2.split("")).join("")
end

def set_digit_map(map_data,map)
    map[1] = map_data.find{ |x| x.length == 2}
    map[7] = map_data.find{ |x| x.length == 3}
    map[4] = map_data.find{ |x| x.length == 4}
    map[8] = map_data.find{ |x| x.length == 7}
    
    five_subset = map_data.filter{ |x| x.length == 5}
    six_subset = map_data.filter{ |x| x.length == 6}
    
    map[3] = five_subset.find{ |x| check_if_contains(x,map[1]) }
    five_subset = five_subset - [map[3]]
    
    map[9] = six_subset.find{ |x| check_if_contains(x,map[3]) }
    six_subset = six_subset - [map[9]]
    
    map[0] = six_subset.find{ |x| check_if_contains(x,map[7]) }
    six_subset = six_subset - [map[0]]
    
    map[5] = five_subset.find{ |x| check_if_contains(x,get_dif(map[4],map[1])) }
    five_subset = five_subset - [map[5]]
    
    map[6] = six_subset[0];
    map[2] = five_subset[0];
end

def convert_sequence_to_digit(sequence,map)
    return map.find_index{ |x| x.chars.sort.join == sequence.chars.sort.join}
end

map = Array.new(10,"")
data = Array.new
total = 0;
number = 0
File.foreach("ex8.txt") { |line| 
    line.chomp!;
    map_data, data = line.split(" | ")
    set_digit_map(map_data.split(" "),map)
    output = data.split(" ");
    number += 1000 * convert_sequence_to_digit(output[0],map)
    number += 100 * convert_sequence_to_digit(output[1],map)
    number += 10 * convert_sequence_to_digit(output[2],map)
    number += convert_sequence_to_digit(output[3],map)
    total += count_simple(output);
}
puts total;
puts number;