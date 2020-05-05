//: [Previous](@previous)
/*:
 # Initializer
 ---
 * Swift 의 객체는 사용하기 전 모든 저장 프로퍼티에 대해 초기화 필수
 * 다음 3 가지 중 하나를 택해 초기화
   * 초기값 지정
   * 옵셔널 타입 - nil 값으로 초기화
   * 초기값이 없고, 옵셔널 타입이 아닌 프로퍼티에 대해서는 초기화 메서드에서 설정
 ---
 */
class Circle {
  var desc: String?
  var radius: Int = 20
  var xCoordinate: Int
  var yCoordinate: Int
  
  init() {
    xCoordinate = 5
    yCoordinate = 10
  }
  
  init(xCoordinate: Int, yCoordinate: Int) {
    self.xCoordinate = xCoordinate
    self.yCoordinate = yCoordinate
  }
}

let circle1 = Circle()
circle1.xCoordinate

let circle2 = Circle(xCoordinate: 10, yCoordinate: 5)
circle2.xCoordinate



/*:
 ---
 ## Designated Initializer
 - 클래스에 반드시 1개 이상 필요
 - 초기화가 필요한 모든 프로퍼티를 단독으로 초기화 가능한 Initializer
 - 위에서 사용한 init(), init(height: Int, xPosition: Int) 가 여기에 해당
 - 초기화 과정에서 반드시 한 번은 호출
 ---
 */

/*:
 ---
 ## Convenience Initializer
 - 단독으로 모두 초기화할 수 없고 일부만 처리한 뒤 다른 생성자에게 나머지 부분 위임
 - 중복되는 초기화 코드를 줄이기 위해 사용
 ---
 */

class Rectangle {
  var width: Int
  var height: Int
  var xPosition: Int
  var yPosition: Int
  var cornerRadius: Int
  
  init() {
    // designated init
    width = 20
    height = 20
    xPosition = 10
    yPosition = 10
    cornerRadius = 5
  }
  
  init(width: Int, height: Int, xPosition: Int, yPosition: Int, cornerRadius: Int) {
    // designated init
    self.width = width
    self.height = height
    self.xPosition = xPosition
    self.yPosition = yPosition
    self.cornerRadius = cornerRadius
    
    // self.init() 사용하면 오류 발생. 쓰고싶으면 convenience를 붙여줘야함.ㅣ // designated init can't call designated init
  }
  
  convenience init(xPosition: Int) {
    // convenience init -> designated init -> overwrite
    self.init() //위에서 초기화 한번 다 해준것들을 기본값으로 하고 그 중에서 인스턴스화 할 때 바꿔주고 싶은 것만 골라서 뜨워줌.
    self.xPosition = xPosition //이 코드를 self.init()위에 작성하면 오류가 나는 이유 : self.  이라는 것은 초기화가 끝난 다음에야 쓸 수 있는 것이기 때문에 먼저 초기화코드를 실행시킬 수 있게 해주어야 되기 때문임.
  }
  
  convenience init(width: Int, height: Int, cornerRadius: Int) {
    // convenience init -> designated init
    self.init(width: width, height: height, xPosition: 10, yPosition: 30, cornerRadius: cornerRadius)
  }

  convenience init(cornerRadius: Int) {
    // convenience init -> convenience init
    self.init(width: 20, height: 20, cornerRadius: cornerRadius)
  }
}

let rectangle1 = Rectangle(xPosition: 20)
let rectangle2 = Rectangle(cornerRadius: 5)
let rectangle3 = Rectangle(width: 10, height: 10, xPosition: 10, yPosition: 5, cornerRadius: 3)


/***************************************************
 초기화 과정은 (Convenience -> Convenience -> ... ->) Designated (최종) 순서로 동작
 Designated -> Designated 호출 불가
 ***************************************************/




/*:
 ---
 ## Failable Initializer
 - 인스턴스 생성시 특정 조건을 만족하지 않으면 객체를 생성하지 않는 것
 - 생성이 되면 옵셔널 타입을 반환하게 되며, 생성 실패시에는 nil 반환
 ---
 */
class Person {
  let name: String
  let age: Int
  
  init?(name: String, age: Int) {
    guard age > 0 else { return nil }
    self.name = name
    self.age = age
  }
}

//Failable Initializer

if let person = Person(name: "James", age: 20) {
  person
}

let person = Person(name: "James", age: 20)

if let person = Person(name: "James", age: -5) {
  person
} else {
  "Failed"
}

let person2 = Person(name: "James", age: -5)
print(person2)
//: [Next](@next)
