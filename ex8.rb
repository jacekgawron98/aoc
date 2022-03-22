def count_simple(data) 
    return data.select{ |digit| (digit.length == 2 || digit.length == 3 || digit.length == 4 || digit.length == 7) }.length
end

def get_digit(mask)
    case mask 
    when "1110111" 
        return 0
    when "0010010"
        return 1
    when "1011101"
        return 2
    when "1011011"
        return 3
    when "0111010"
        return 4
    when "1101011"
        return 5
    when "1101111"
        return 6
    when "1010010"
        return 7
    when "1111111"
        return 8
    when "1111011"
        return 9
    end
    return -1;
end

def get_mask(sequence)
    return "0000000"
end

def convert_sequence_to_digit(sequence)
    mask = get_mask(sequence)
    return get_digit(mask)
end

data = Array.new
total = 0;
File.foreach("ex8.txt") { |line| 
    line.chomp!;
    data = line.split(" | ")[1];
    output = data.split(" ");
    total += count_simple(output);
}
puts total;