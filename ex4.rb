def check_bingo(array=[])
    5.times do |index|
        column = array.map { |element| element[index] }
        sum_col = column.inject(:+)
        row = array.transpose.map { |element| element[index] }
        sum_row = row.inject(:+)
        if sum_col == -5 || sum_row == -5
            return true
        end
    end
    return false
end

def mark_board2(array=[],value)
    copy = array
    last_won = []
    array.each.with_index do |board,index|
        board.select{ |row| row.include?(value) }.each do |row|
            row.map!{ |x| x == value ? -1 : x}
        end 
        if check_bingo(board)
            last_won = board
            copy = copy.reject{ |v| v == board }
        end
    end
    return copy, last_won
end

def mark_board(array=[],value)
    array.each do |board|
        board.select{ |row| row.include?(value) }.each do |row|
            row.map!{ |x| x == value ? -1 : x}
        end 
        if check_bingo(board)
            return board, true
        end
    end
    return array[0], false
end

def get_score(array=[])
    return array.flatten.select{ |x| x != -1}.inject(:+)
end

#pewno się da lepiej zrobić wczytywanie :P
arr = Array.new
data = []
counter = -1
$stdin.each do |line|
    line.chomp!
    if line.empty?
        counter += 1
        arr << []
    else
        if line == "q"
            break
        end
    
        if counter == -1
            data = line.split(',').map(&:to_i)
        else
            arr[counter] << line.split.map(&:to_i)
        end
    end

end

last_bingo = []
last_val = -1
data.each do |value|
    arr, board = mark_board2(arr,value)
    if board != []
        last_bingo = board
        last_val = value 
    end
end
puts "bingo"
puts last_bingo.map{ |x| x.join(' ') }
puts
puts get_score(last_bingo) * last_val
