openings = ['(','{','[','<']
endings = [')',']','}','>']

def get_end(data)
    case data
    when '('
        return ')'
    when '['
        return ']'
    when '{'
        return '}'
    when '<'
        return '>'
    end 
end

def check_chunk(data, characters, position, openings, endings)
    if position+1 > data.length
        return ""
    end

    if data[position+1] == get_end(characters.last())
        characters.pop()
        return check_chunk(data, characters, position+1, openings, endings)
    elsif endings.include?(data[position+1]) && data[position+1] != get_end(characters.last())
        return data[position+1]
    end

    if openings.include?(data[position+1])
        characters.push(data[position+1])
        return check_chunk(data, characters, position+1, openings, endings)
    end
end

def get_score(data) 
    case data
    when ')'
        return 3
    when ']'
        return 57
    when '}'
        return 1197
    when '>'
        return 25137
    else
        return 0
    end
end

def get_score2(data,endings)  
    #puts data.join(" ")
    #puts data.map.with_index{ |x,i| endings.find_index(data[i])+1}.inject { |sum, n| 5*sum + n}
    return data.map.with_index{ |x,i| endings.find_index(data[i])+1}.inject { |sum, n| 5*sum + n}
end

score = 0
score2 = []
data = Array.new
File.foreach("ex10.txt") { |line| 
    line.chomp!
    characters = [line[0]]
    character = check_chunk(line,characters,0,openings,endings)
    result = get_score(character)
    score += result
    if result == 0
        score2.push(get_score2(characters.reverse.map{ |c| get_end(c) }, endings));
    end
}

puts score
puts score2.sort[score2.length/2]