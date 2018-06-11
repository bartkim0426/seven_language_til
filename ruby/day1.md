## Ruby

## 2.2 1일차

### 2.2.3 프로그래밍 모델

- 루비는 순수한 객체 지향 언어.
- 파이썬과 흡사하다

### 결정 (T/F)
- 파이썬과 기본적으로 동일
- nli, false를 제외한 모든것은 true로 평가 (0도 `true`인 점이 파이썬과 조금 다른다)

### 2.2.5 오리타이핑
- 루비는 기본적으로 `강한 타이핑` (자료형이 충돌을 일으키면 에러 발생)
- 컴파일이 아니라 실행중에 수행: `dynamic typing`(동적 타이핑)
- `def`로 함수를 정의하면 에러 X
- 루비 타이핑의 장점: 클래스가 동일한 방식으로 행동하기 위해서 같은 부모로부터 상속받을 필요는 없다?

**오리 타이핑 예제**

```ruby
>> i = 0
=> 0
>> a = ['100', 100.0]
>> while i < 2
>>  puts a[i].to_i
>> end
100
100
```

- 첫번째는 string, 두번째는 float.
- `to_i` 메소드를 통해 정수로 바뀜
- 오리타이핑? 실제로 주어진 자료형이 무엇인지 신경쓰지 않음. 오리처럼 꽥꽥거리면 그것은 오리! (to_i)

### 1일차 내용
- 루비는 인터프리트 되는 객체지향 언어
- 오리 타이핑 사용, 대부분 강한 타이핑 시스템.


### 1일차 자율학습

```ruby
# 'Hello world' 출력
>> puts 'hello world'

# 'Hello, Ruby'에서 'Ruby' 인덱스 찾기
# https://stackoverflow.com/questions/10668415/how-do-i-find-the-index-of-a-character-in-a-string-in-ruby
>> 'Hello, Ruby'.index('Ruby')
=> 7

# 이름 열번 출력
# while 사용
>> i = 0
>> while i < 10
>>     puts 'seulchan kim'
>>     i += 1
>> end

# for 사용
>> for i in 0..9
>>     puts 'seulchan kim'
>> end

# 1~10 대상으로 `This is sentence number 1` 출력
# for 사용
>> for i in 0..9
>>     puts "This is sentence number #{i+1}"
>> end

# until 사용
>> i = 0
>> until i == 10
>>     puts "This is sentence number #{i+1}"
>>     i += 1
>> end

# 파일에서 읽은 루비 프로그램 실행?
# ruby test.rb 로 실행

# (보너스):임의 숫자 고르는 프로그램 작성. 추측하게 하고 그 값이 큰지 작은지 화면에
# https://stackoverflow.com/questions/198460/how-to-get-a-random-number-in-ruby

# pick number and match it to random number
# in 'pick_the_num.rb' file
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
```
