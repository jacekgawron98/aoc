def get_position(commands,values)
    if commands.length == 0
        return 0,0
    end
    x,y = 0,0
    if commands[0] == "up"
        y = -values[0]
    elsif commands[0] == "down"
        y = values[0]
    elsif commands[0] == "forward"
        x = values[0]
    end
    val = get_position(commands.drop(1),values.drop(1))
    x += val[0]
    y += val[1]
    return x,y 
end

def get_position2(commands,values,aim=0)
    x,y,a = 0,0,0
    commands.each_with_index do |c,i|
        if c == "up"
            a += -values[i]
        elsif c == "down"
            a += values[i]
        elsif c == "forward"
            x += values[i]
            y += a * values[i]
        end
    end
    return x,y,a
end

c = Array.new
v = Array.new
$stdin.each do |line|
    command, value = line.split
    if line.chomp.empty?
        break
    end
    c << command
    v << value.to_i
end
val = get_position2(c,v)
puts val[0] * val[1]