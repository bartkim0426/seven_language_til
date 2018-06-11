## 2.2 2일차


### 2.2.1 함수정의
- 루비에서는 return을 설정하지 않으면 마지막 표현이 자동으로 리턴

### 2.2.2 배열
- 파이썬과 거의 흡사
- `[]`, `[]=`는 배열을 위해 제공되는 syntax suger: 사실 array 객체에 정의된 메소드의 이름!

```ruby
>> [1].methods.include?(:[])
=> true
```

### 2.2.3 해시
- 해시 바구니에는 모든 객체가 특정한 레이블 (key), 객체는 값(value)

```ruby
2.4.1 :041 > numbers = {1 => 'one', 2 => 'two'}
 => {1=>"one", 2=>"two"}
2.4.1 :042 > numbers
 => {1=>"one", 2=>"two"}
2.4.1 :043 > numbers[1]
 => "one"
2.4.1 :044 > numbers[2]
 => "two"
2.4.1 :045 > stuff = {:array => [1, 2, 3], :string => 'Hi, mom!'}
 => {:array=>[1, 2, 3], :string=>"Hi, mom!"}
2.4.1 :046 > stuff
 => {:array=>[1, 2, 3], :string=>"Hi, mom!"}
2.4.1 :047 > stuff[:string]
 => "Hi, mom!"
2.4.1 :048 >
```

- 위에서 `:string`은 `symbol`. 
- symbol은 식별자가 같다면 동일한 존재 (반면에 동일한 값을 갖는 문자열은 다른 객체일수 있음)

```ruby
2.4.1 :055 > :string.object_id
 => 276508
2.4.1 :056 > :string.object_id
 => 276508
2.4.1 :057 > 'string'.object_id
 => 70307486515000
2.4.1 :058 > 'string'.object_id
 => 70307486496640
2.4.1 :059 >
```

### 2.3.4 코드블록과 yield

```ruby
2.4.1 :069 > animals = ['lions and ', 'tigers and', 'bears', 'oh my']
 => ["lions and ", "tigers and", "bears", "oh my"]
2.4.1 :070 > animals.each {|a| puts a}
lions and
tigers and
bears
oh my
 => ["lions and ", "tigers and", "bears", "oh my"]
```

```ruby
2.4.1 :071 > class Fixnum
2.4.1 :072?>   def my_times
2.4.1 :073?>     i = self
2.4.1 :074?>     while i > 0
2.4.1 :075?>       i = i -1
2.4.1 :076?>       yield
2.4.1 :077?>       end
2.4.1 :078?>     end
2.4.1 :079?>   end
(irb):71: warning: constant ::Fixnum is deprecated
 => :my_times
2.4.1 :080 > 3.my_times {puts 'mangy moose'}
mangy moose
mangy moose
mangy moose
 => nil
2.4.1 :081 >
```


> :Fixnum이 deprecated되고 기본형이 Integer로 변경됨

### 2.3.6 class

```ruby
2.4.1 :001 > 4.class
 => Integer
2.4.1 :002 > 4.class.superclass
 => Numeric
2.4.1 :003 > 4.class.superclass.superclass
 => Object
2.4.1 :004 > 4.class.superclass.superclass.superclass
 => BasicObject
2.4.1 :005 > 4.class.superclass.superclass.superclass.superclass
 => nil
2.4.1 :006 > 4.class.class
 => Class
2.4.1 :007 > 4.class.class.superclass
 => Module
2.4.1 :008 > 4.class.class.superclass.superclass
 => Object
2.4.1 :009 >
```
- 루비의 모든 존재는 Ojbect라는 하나의 공통 조상

```ruby
class Tree
    attr_accessor :children, :node_name

    def initialize(name, children=[])
        @children = children
        @node_name = name
    end

    def visit_all(&block)
        visit &block
        children.each {|c| c.visit_all &block}
    end

    def visit(&block)
        block.call self
    end
end

ruby_tree = Tree.new("Ruby",
                     [Tree.new("Reia"),
                      Tree.new("MacRuby")])

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}
```

- 루비의 전통과 규칙: 클래스는 대문자, CamelCase / 인스턴스 변수 앞에는 `@`, underscore_style / 상수는 모두 대문자

### 2.3.7 믹스인 작성하기

- 다중 상속의 문제를 해결하기 위해서 ruby는 module을 사용

```ruby
module ToFile
    def filename
        "object_#{self.object_id}.txt"
    end
    def to_f
        File.open(filename, 'w') {|f| f.write(to_s)}
    end
end

class Person
    include ToFile
    attr_accessor :name

    def initialize(name)
        @name = name
    end
    def to_s
        name
    end
end

Person.new('matz').to_f
```
- 오리타이핑 => `to_s`가 모듈이 아니라 클라스 안에서 정의되어짐

### 2.3.8 모듈, enumerable, 집합

- 루비에서 가장 중요한 의미를 같는 믹스인: `enumerable`, `comparable`
- `enumerable`: each를 구현해야함
- `comparable`: `<=>`를 구현: 우주선(spaceship) 연산자

```ruby
2.4.1 :001 > 'begin' <=> 'end'
 => -1
2.4.1 :002 > 'same' <=> 'same'
 => 0
2.4.1 :003 > 'short' <=> 'loooong'
 => 1
2.4.1 :004 > a = [5, 3, 4, 1]
 => [5, 3, 4, 1]
2.4.1 :005 > a.sort
 => [1, 3, 4, 5]
2.4.1 :006 > a.any? {|i| i > 6}
 => false
2.4.1 :007 > a.all? {|i| i > 4}
 => false
2.4.1 :008 > a.all? {|i| i > 0}
 => true
2.4.1 :009 > a.collect {|i| i > 0}
 => [true, true, true, true]
2.4.1 :010 > a.collect {|i| i * 2}
 => [10, 6, 8, 2]
2.4.1 :012 > a
 => [5, 3, 4, 1]
2.4.1 :013 > a.select {|i| i % 2 == 0}
 => [4]
2.4.1 :014 > a.select{|i| i % 2 == 1}
 => [5, 3, 1]
2.4.1 :015 > a.max
 => 5
2.4.1 :016 > a.member?(2)
 => false
```


- inject
```ruby
2.4.1 :018 > a.inject(0) {|sum, i| sum + i}
 => 13
2.4.1 :019 > a.inject {|sum, i| sum + i}
 => 13
2.4.1 :020 > a.inject {|product, i| product * i}
 => 60
2.4.1 :021 > a.inject(0) do |sum, i|
2.4.1 :022 >     puts "sum: #{sum} i: #{i}   sum + i: #{sum + i}"
2.4.1 :023?>   sum + i
2.4.1 :024?>   end
sum: 0 i: 5   sum + i: 5
sum: 5 i: 3   sum + i: 8
sum: 8 i: 4   sum + i: 12
sum: 12 i: 1   sum + i: 13
 => 13
```


