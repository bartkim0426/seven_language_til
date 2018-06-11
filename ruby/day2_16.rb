# 16개 수를 가진 배열의 내용을 each만 사용해서 한번에 4개씩 출력. enumerable 안에 있는 each_slice를 이용해서 동일한 작업

number_list = [*1..16]

number = 1
number_list.each do |item|
    index = number_list.index(item)
    if (number_list.index(item)+1) % 4 == 1
        puts "item: #{number}"
        puts number_list[index..index+3]
        number += 1
    end
end

# each_slice 사용
number_list.each_slice(4).to_a

# correct answer 
number_list.each { |i|print "#{i}#{i % 4 == 0 ? "\n" : ','}" }
