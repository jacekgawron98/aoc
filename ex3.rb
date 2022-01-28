def convert_binary_to_dec(binary)
    result = 0
    binary.reverse.chars.map.with_index do |d, index|
        result += d.to_i * 2 ** index
    end
    return result
end

def measure_bits(size=0,m)
    gamma, epsilon = "", ""
    size.times do |index|
        z,o = 0,0
        m.each do |value|
            if value[index] == '1' 
                o += 1
            else 
                z += 1
            end
        end
        if o > z 
            gamma << '1'
            epsilon << '0'
        else
            gamma << '0'
            epsilon << '1'
        end
    end
    return gamma, epsilon
end

def filter_bits(m,size=0,down=false)
    new_m = m
    size.times do |index|
        m_one_size = new_m.select{ |item| item[index] == '1'}.length
        m_zero_size = new_m.select{ |item| item[index] == '0'}.length
        val = m_one_size >= m_zero_size ? '1' : '0'
        val2 = m_one_size >= m_zero_size ? '0' : '1'
        if down
            new_m = new_m.select{|item| item[index] == val2}
        else
            new_m = new_m.select{|item| item[index] == val}
        end
        if new_m.length == 1
            break
        end
    end
    return new_m
end

m = Array.new
$stdin.each do |line|
    line.chomp!
    if line.empty?
        break
    end
    m << line
end
size = m[0].length
co2 = filter_bits(m,size,true)
oxygen = filter_bits(m,size)
puts "something" 
puts co2, oxygen
puts convert_binary_to_dec(co2[0]), convert_binary_to_dec(oxygen[0])
puts convert_binary_to_dec(co2[0]) * convert_binary_to_dec(oxygen[0])
#gamma, epsilon = measure_bits(size,m)
#puts gamma, epsilon
#puts convert_binary_to_dec(gamma), convert_binary_to_dec(epsilon)
#puts convert_binary_to_dec(gamma) * convert_binary_to_dec(epsilon)
