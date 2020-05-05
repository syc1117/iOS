//: [Previous](@previous)
import UIKit
/*:
 ---
 # Comparing Structures and Classes
 ---
 */

/*
 [ 클래스와 구조체 공통점 ]
 - 값을 저장하기 위한 프로퍼티
 - 기능을 제공하기 위한 메서드
 - 초기 상태를 설정하기 위한 생성자
 - 기본 구현에서 기능을 추가하기 위한 확장(Extension)
 - 특정 값에 접근할 수 있는 첨자(Subscript)
 - 특정한 기능을 수행하기 위한 프로토콜 채택
 - Upper Camel Case 사용
 */


class SomeClass {
  var someProperty = 1
  func someMethod() {}
}
struct SomeStruct {
  var someProperty = 1
  func someMethod() {}
}

let someClass = SomeClass()
let someStruct = SomeStruct()



/*
 [ 클래스만 제공하는 기능 ]
 - 상속 (Inheritance)
 - 소멸자 (Deinitializer)
 - 참조 카운트 (Reference counting)
 */


// 상속
struct ParentS {}
//struct Child: Parent {}   // 오류


// 소멸자
struct Deinit {
//  deinit { }    // 오류
}

// 참조 카운트(Reference Counting)  X




/*:
 ---
 #### 값 타입 vs 참조 타입
 ---
 */
class Dog {
  var name = "토리"
}
struct Cat {
  var name = "릴리"
}
/* Struct는 let 쓸때 조심해야함. 값변경이 안되기 때문 */
let dog = Dog() //let 은 스택 정보를 고정하는 것으로 Dog()는 클래스이므로 주소값만 고정되기 때문에 값 변경이 가능함.
let cat = Cat() //구조체의 경우에는 바로 스택에 정보가 저장되므로 let으로 선언하면 내부의 프로퍼티가 var로 선언되어 있더라도 값 변경이 이루어지지 않음.

//dog.name = "릴리"
//cat.name = "토리"





let dog1 = dog
var cat1 = cat
dog1.name = "뽀삐"
cat1.name = "뽀삐"
dog.name
cat.name


//dog === dog1
//cat === cat1



/*:
 ---
 #### 생성자 비교
 ---
 */
/*
 var로 선언된 변수
 */

class UserClass1 {
  var name = "홍길동"
}
struct UserStruct1 {
  var name = "홍길동"
}

let userC1 = UserClass1()
let userS1_1 = UserStruct1()
let userS1_2 = UserStruct1(name: "깃봇")
userS1_1.name
userS1_2.name



/*
 프로퍼티에 초기화 값이 없을 때
 */

class UserClass2 {
  var name: String
  // 초기화 메서드 없으면 오류
  init(name: String) { self.name = name }
}

struct UserStruct2 {
  var name: String
  var age: Int
  
  // 초기화 메서드 자동 생성
  // 단, 생성자를 별도로 구현했을 경우 자동 생성하지 않음
//  init(name: String) {
//    self.name = name
//    self.age = 10
//  }
}

let userC2 = UserClass2(name: "홍길동")
let userS2 = UserStruct2(name: "홍길동", age: 10)



/*
 저장 프로퍼티 중 일부에만 초기화 값이 있을 때
 */

class UserClass3 {
  let name: String = "홍길동"
  // 저장 프로퍼티 중 하나라도 초기화 값이 없는 경우 생성자를 구현해야 함
//  let age: Int
}

struct UserStruct3 {
  let name: String = "홍길동"
  let age: Int
}
// 초기화 값이 없는 저장 프로퍼티에 대해서만 생성자로 전달
let userS3 = UserStruct3(age: 10)




/*
 지정(Designated) 생성자, 편의(Convenience) 생성자
 */
class UserClass4 {
  let name: String
  let age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
  convenience init(age: Int) {
    self.init(name: "홍길동", age: age)
  }
}

struct UserStruct4 {
  let name: String
  let age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
  
  // Convenience 키워드 사용 X, 지정과 편의 생성자 별도 구분 없음
//  convenience init(age: Int) {
  init(age: Int) {
    self.init(name: "홍길동", age: age)
  }
}

// 따라서 extension에서도 생성자 추가 가능
extension UserStruct4 {
  init(name: String) {
    self.name = name
    self.age = 10
  }
}

let userS4_1 = UserStruct4(name: "홍길동")
let userS4_2 = UserStruct4(age: 20)





/*:
---
#### 프로퍼티 변경
---
*/

struct PointStruct {
  var x = 0
  
//  func updateX() {   //enum이나 struct는 값타입이므로 내부에서 내부의 프로퍼티 값을 변경하는 함수를 사용할 때 반드시 mutating을 붙여야함.
//    self.x = 5
//  }

//  var updateProperty: Int {
//    get { x }
//    set { x = newValue }    // 연산 프로퍼티의 setter는 기본적으로 mutating
//  }
}


//let p2 = PointStruct()
//var p2 = PointStruct()
//p2.updateX()
//p2.updateProperty = 3
//p2.updateProperty




class PointClass {
  var x = 0
  
//  mutating: 클래스에서는 mutating사용하면 에러 발생함
  func updateX() {
    self.x = 5
  }
}

let p1 = PointClass()
p1.updateX()




/*:
 ---
 #### 프로토콜 적용
 ---
 */


// mutating

protocol Mutate {
//  func update()
//  mutating func mutatingUpdate()
}
struct PointStruct1: Mutate {
  var x = 0
  
  mutating func update() {
    self.x = 5
  }
}







/*
/*
 [ 클래스와 구조체 공통점 ]
 - 값을 저장하기 위한 프로퍼티
 - 기능을 제공하기 위한 메서드
 - 초기 상태를 설정하기 위한 생성자
 - 기본 구현에서 기능을 추가하기 위한 확장(Extension)
 - 특정 값에 접근할 수 있는 첨자(Subscript)
 - 특정한 기능을 수행하기 위한 프로토콜 채택
 - Upper Camel Case 사용
 */

/*
[ 클래스만 제공하는 기능 ]
- 상속 (Inheritance)
- 소멸자 (Deinitializer): Heap에 관련된 것으로 struct와 무관함.
- 참조 카운트 (Reference counting): Heap에 관련된 것으로 struct와 무관함.
*/

/*
[struct의 특징]
- 초기화 값이 없을 경우 내부에 init()을 자동 생성함. 따로 지정하면 생성 안됨.
- 지정생성자, 편의생성자 구분없음. 구조체는 extention에서 init 사용 가능함.
  (클래스의 경우 Extention에서 무조건 편의 생성자만 사용 가능함.)
 */
*/



//: [Next](@next)
