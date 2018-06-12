## 2.3 3일

### 오픈클래스
- 객체/클래스를 언제든 다시 정의 가능
- `String`, `NilClass`와 같은 기본 클래스에도 메소드 추가 가능

#### `blank.rb`

```ruby
class NilClass
    def blank?
        true
    end
end

class String
    def blank?
        self.size == 0
    end
end

["", "person", nil].each do |element|
    puts element unless element.blank?
end
```

- 위 예시는 `String`의 blank와 null 값을 동시에 확인 가능한 `blank?`를 추가
- 큰 힘엔 큰 위험이 따른다!

### method_missing

- 어떤 메서드가 없을 때 시스템 진단을 출력하는 디버깅 메소드
- 이를 override해서 메서드 추가 없이 기능 동작 가능
- 역시나 디버깅 수행이 어려움...

```ruby
class Roman
    def self.method_missing name, *args
        roman = name.to_s
        roman.gsub!("IV", "IIII")
        roman.gsub!("IX", "VIIII")
        roman.gsub!("XL", "XXXX")
        roman.gsub!("XC", "LXXXX")

        (roman.count("I") +
         roman.count("V") * 5 +
         roman.count("X") * 10 +
         roman.count("L") * 50 +
         roman.count("C") * 100
        )
    end
end

puts Roman.X
puts Roman.XC
puts Roman.XII
```


### Module

- class name과 같은 csv 파일 읽어내는 모듈
- `acts_as_csv_class.rb`
```ruby
class ActsAsCsv
    def read
        file = File.new(self.class.to_s.downcase + '.csv')
        @headers = file.gets.chomp.split(',')

        file.each do |row|
            @result << row.chomp.split(', ')
        end
    end

    def headers
        @headers
    end

    def csv_contents
        @result
    end

    def initialize
        @result = []
        read
    end
end

class RubyCsv < ActsAsCsv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
```

- 단순히 메소드 4개만 정의한 기존 클라스와 달리 `module method`(`macro`)를 클래스에 덧붙임
- 매크로는 클라스의 행위를 주변 환경의 변화와 맞춰 변경

```ruby
class ActsAsCsv
    def self.acts_as_csv
        define_method "read" do
            file = File.new(self.class.to_s.downcase + '.csv')
            @headers = file.gets.chomp.split(', ')

            file.each do |row|
                @result << row.chomp.split(', ')
            end
        end

        define_method "headers" do
            @headers
        end

        define_method "csv_contents" do
            @result
        end

        define_method "initialize" do
            @result = []
            read
        end
    end
end

class RubyCsv < ActsAsCsv
    acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
```
- 목표 클래스가 `acts_ac_csv`를 호출하면 목표 클래스 위에 메서드를 정의
- 메서드가 목표 클래스에 추가가 됨
- 이를 더 잘 보여주는 예시

```ruby
module ActsAsCsv
    def self.included(base)
        base.extend ClassMethods
    end

    module ClassMethods
        def acts_as_csv
            include InstanceMethods
        end
    end

    module InstanceMethods
        def read
            @csv_contents = []
            filename = self.class.to_s.downcase + '.csv'
            file = File.new(filename)
            @headers = file.gets.chomp.split(', ')

            file.each do |row|
                @csv_contents << row.chomp.split(', ')
            end
        end

        attr_accessor :headers, :csv_contents
        def initialize
            read
        end
    end
end

class RubyCsv
    include ActsAsCsv
    acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
```

- 모듈 생성: 모듈이 포함될 때마다 `self.included` 실행 => `ClassMethods`를 확장 => `acts_as_csv` 정의 => `InstanceMethods` include => initialize

### 자율학습

```ruby
# CsvRow 객체를 리턴하는 each method를 지원하도록 CSV application 수정. 주어진 헤딩 값에 해당하는 칼럼 값을 리턴하도록 method_missing 사용

# 추후에 제대로 풀어보기
```
