def get_window!(measurements,new_m,current=0)
    measurements.each do
        if current + 2 >= measurements.length
            break
        end
        new_m << measurements[current] + measurements[current+1] + measurements[current+2]
        current += 1
    end
end

def measure_change(measurements=[],current=0)
    if current == 0
        return 0
    elsif measurements[current] > measurements[current-1]
        return 1 + measure_change(measurements,current-1)
    else 
        return measure_change(measurements,current-1) 
    end
end

m = Array.new
new_m = Array.new
$stdin.each do |line|
    line.chomp!
    if line.empty?
        break
    end
    m << line.to_i
end
get_window!(m,new_m)
puts measure_change(new_m,new_m.length-1)