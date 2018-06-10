# pick number and match it to random number

random_num = rand(100)
i = 0
puts "Let's find out random number!"

def pick_the_num(random_num, i)
    puts "Please pick a number between 0 to 100!"
    picked_num = gets

    if Integer(picked_num) == random_num
        puts "Bingo! the random number is #{random_num}"
        puts "You got the answer with just #{i} times"
    else
        if Integer(picked_num) > random_num
            puts "Opps, your number is bigger than answer"
        else
            puts "Opps, your number is smaller than answer"
        end
        i += 1
        pick_the_num(random_num, i)
    end
end

pick_the_num(random_num, i)
