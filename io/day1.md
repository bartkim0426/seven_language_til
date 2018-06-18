## IO

### 1일

### Install

```bash
brew install io
```


### 안면트기

```io
Io> "Hi, Io" print
Hi, Io==> Hi, Io
```

- io는 이미 존재하는 객체를 통해서 새로운 객체 생성: 이미 존재하는 객체가 프로토타입
- 객체는 슬롯의 컬렉션
- 메세지를 보내서 슬롯에 담긴 값을 받을 수 있음

```io
Io> Vehicle := Object clone
==>  Vehicle_0x7fd216595500:
  type             = "Vehicle"

Io> Vehicle description := "Something to take you places"
==> Something to take you places

Io> Vehicle
==>  Vehicle_0x7fd216576fd0:
  description      = "Something to take you places"
  type             = "Vehicle"

Io> Vehicle slotNames
==> list(type, description)
```

### 객체, 프로토타입, 상속
- `Vehicle`에 속하는 `Car`가 있다고 했을 때 프로토타입 언어에서 이를 어떻게 해결하는지

```io
Io> Car := Vehicle clone
==>  Car_0x7fc7be722650:
  type             = "Car"

Io> Car slotNames
==> list(type)
Io> Car type
==> Car
Io> Car description
==> Something to take you places
```

- `Car`에는 `description` 슬롯이 없기 때문에 이를 프로토타입인 `Vehicle`로 전달 => 이를 발견
- 이를 똑같이 `ferrari`로 할당해도 마찬가지

```io
Io> ferrari := Car clone
==>  Car_0x7fc7be72e8b0:

Io> ferrari slotNames
==> list()

Io> ferrari type
==> Car
```

- 관습적으로 io는 타입이 대문자로 시작 => 소문자로 시작하는 `ferrari`는 type 호출시 프로토타입이 정의하는 타입 (`Car`)
- No interface, No module, NO class, no metaclass
- 단순히 해당 이름을 가진 슬롯이 없다면 객체의 부모(프로토타입)에 메세지를 전달
- `Ruby`에서 클라스는 객체를 생성하기 위한 템플릿: 객체와 클래스는 완전히 다른 존재
- 하지만 io는 객체로부터(프로토타입) 객체를 만들어냄

### 메서드

```io
Io> method("So you've come for an argument" println)
==> method(
    "So you've come for an argument" println
)

Io> Car drive := method("Vroom" println)
==> method(
    "Vroom" println
)
Io> ferrari drive
Vroom
==> Vroom
```

- 이게 io가 가진 핵심적인 코드의 전부
- 다음과 같은 방식으로 슬롯의 내용을 꺼내볼 수 있다 (`getSlot`)
- 객체의 프로토타입을 찾아볼수도 (`proto`) 있고
- `Lobby` (전체 객체의 이름을 담고 있음)를 확인할 수도 있다

```io
Io> ferrari getSlot("drive")
==> method(
    "Vroom" println
)
Io> ferrari getSlot("type")
==> Car
Io> ferrari proto
==>  Car_0x7fc7be722650:
  drive            = method(...)
  type             = "Car"

Io> Car proto
==>  Vehicle_0x7fc7be488ef0:
  description      = "Something to take you places"
  type             = "Vehicle"

==>  Object_0x7fc7be514580:
  Car              = Car_0x7fc7be722650
  Lobby            = Object_0x7fc7be514580
  Protos           = Object_0x7fc7be5144a0
  Vehicle          = Vehicle_0x7fc7be488ef0
  _                = Object_0x7fc7be514580
  exit             = method(...)
  ferrari          = Car_0x7fc7be72e8b0
  forward          = method(...)
  set_             = method(...)
  vehicle          = Object_0x7fc7be707e10
```

기초적인 규칙 정리

- 모든 것이 객체
- 모든 상호작용은 객체에 메세지를 보내는 방식으로
- 클래스로 인스턴트 만들지 않음 => 프로토타입이라는 객체를 복제해서 만든다
- 객체는 자신의 프로토타입을 기억
- 객체는 슬롯을 갖는다
- 슬롯은 객체를 담는다 (메서드 객체를 포함해서)
- 메세지는 슬롯에 담긴 값을 리턴하거나 그 안에 있는 메서드를 호출한다
- 메세지는 슬롯에 담긴 값을 리턴하거나 그 안에 있는 메서드를 호출
- 객체가 자신에게 전달된 메세지에게 응답할수 없으면 프로토타입의 메세지를 전송


### List & Map

```io
Io> toDos := list("fine my Car", "find Continum Transfunctioner")
==> list(fine my Car, find Continum Transfunctioner)
Io> toDos
==> list(fine my Car, find Continum Transfunctioner)
Io> toDos size
==> 2
Io> toDos append("Find a present")
==> list(fine my Car, find Continum Transfunctioner, Find a present)

# 다음과 같이 편하게 만들수도 있음
Io> list(1, 2, 3, 4)
==> list(1, 2, 3, 4)
```

- `list`는 수학, 스택 등 자료형을 다루는데 사용되는 편리한 연산도 포함하고 있다

```io
Io> list(1, 2, 3, 4) average
==> 2.5
Io> list(1, 2, 3, 4) sum
==> 10
Io> list(1, 2, 3) at (1)
==> 2
Io> list(1, 2, 3, 4) append(4)
==> list(1, 2, 3, 4, 4)
Io> list (1, 2, 3) pop
==> 3
Io> list(1, 2, 3) prepend(0)
==> list(0, 1, 2, 3)
Io> list() isEmpty
==> true
```
