//: [Previous](@previous)
/*:
 # Equatable, Identical
 */

// 동등 연산자
1 == 1
2 == 1
"ABC" == "ABC"


class Person {
  let name = "이순신"
  let age = 30
}

let person1 = Person()
let person2 = Person()

//person1 == "이순신"    //
//person1 == person2   //


/*:
 ---
 ### Question
 - 왜 비교 연산자를 사용할 수 없을까요?
 ---
 */

/*:
 ---
 ### Equatable Protocol
 ---
 */

class User: Equatable { //
  var name = "이순신"
  let age = 30
  
  static func ==(lhs: User, rhs: User) -> Bool {//Equatable 프로토콜사용시 사용해야하는 함수
    return lhs.name == rhs.name //이름이 같으면 참을 뱉음
  }
}

let user1 = User()
var user2 = User()
user1 == user2 //클래스끼리 비교할 수 있게 되었음


/*:
 ---
 ### Identical
 ---
 */

user1.name
user2.name
user1 == user2
user1 === user2 //===은 stack 상에서 값을 비교 user1,user2의 값은 클래스로서 스택에 주소정보를 남기고 힙에 저장됨. 따라서 스택에서는 서로 다른 주소값으로 저장되어있음.
//스택은 푸시 앤 팝, 힙은 무작위(공간상황봐서 아무데나 들어감)


/*
 let x = 5
 let y = User()
 let z = User()
 
           x   y        z
 [ Stack ] | 5 | 0x5F17 | 0x2C90 |
                   |        |
                   ---------|----------
           ------------------         |
           |                          |
         0x2C90          0x5F16     0x5F17
 [ Heap ]  | z's user data | SomeData | y's user data |
 
 --- in Memory ---
 값 타입(Value Type) - Stack
 참조 타입(Reference Type) - Stack -> Heap
 */


user1.name = "홍길동"
user1.name   //
user2.name   //
user1 == user2
user1 === user2


user2 = user1 //user2를 user1에 같게 만듦 스택상의 주소값이 같아 지는 것


// user1 -> 0x00001  <- user2       0x00002

user1.name
user2.name
user1 == user2    //
user1 === user2   //

user2.name = "세종대왕"
user2.name
user1.name
//위에서 참조하는 주소가 스택상에서 같아졌기 때문에 같은 값을 호출하는 것임.

/*
 Identity Operators
 === : 두 상수 또는 변수가 동일한 인스턴스를 가르키는 경우 true 반환
 */
//
//1 === 1
//"A" === "A"
//
// 5 == 5


//: [Next](@next)
