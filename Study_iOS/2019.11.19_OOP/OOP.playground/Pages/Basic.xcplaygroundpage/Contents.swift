//: [Previous](@previous)
/*:
 # Class
 */
/*
 Value Type => struct, enum  (Stack 에 저장)
 Reference Type => class  (Heap 에 저장)
 */


/*
 let x = 5
 let y = User() : User()라는 클래스로 할당하게 되면 heap에 저장되고 stack에는 접근가능한 코드가 남음.(0x5F17)
 let z = User()
 
         x   y        z
 [Stack] | 5 | 0x5F17 | 0x2C90 |
 
        0x2C90          0x5F16     0x5F17
 [Heap] | z's user data | SomeData | y's user data |
 
 --- in Memory ---
 값 타입(Value Type) - Stack
 참조 타입(Reference Type) - Stack -> Heap
 */


/*
 class <#ClassName#>: <#SuperClassName#>, <#ProtocolName...#> {
   <#PropertyList#>
   <#MethodList#>
 }
 
 let <#objectName#> = <#ClassName()#>
 objectName.<#propertyName#>
 objectName.<#functionName()#>
 */

//Swift : POP 를 지향하는 멀티 패러다임 언어
//POP : Protocol-Oriented Programming
//객체지향 프로그래밍 이란 캡슐화, 다형성, 상속 을 이용하여 코드 재사용을 증가시키고, 유지보수를 감소시키는 장점을 얻기 위해서 객체들을 연결시켜 프로그래밍 하는 것
/*언어 또는 기술이 다음 사항들을 직접 지원한다면 객체 지향
추상화 : 클래스나 객체를 제공
상속 : 이미 존재하는 것으로부터 새로운 추상화를 만들어 낼 능력을 제공
런타임 다형성 : 수행 시간에 바인딩 할 수 있는 어떠한 폼을 제공*/
//객체 : 데이터 (상태) + 메서드 (행위)
//최초의 OOP 언어 : Smalltalk    /  Smalltalk + C —> Objective-C
/*Q. 다음 용어의 차이점은?
   - 함수 (Function) ?
메서드 (Method) ?
 class, struct 등 객체 안에 들어가면 메서드, 밖에 있으면 함수라고 함.*/
/*[ Class ]
추상 (abstract) , 표현 대상에 대한 이데아(형상)
이상적인 존재  (이미지, 설계도, 틀, 설명서)
공통의 특징

 [ Object ]
실체 (instance) , 추상을 실체화한 대상
이데아의 모사
개별 속성*/
class Dog {
  var color = "White"
  var eyeColor = "Black"
  var height = 30.0
  var weight = 6.0
  
  func sit() {
    print("sit")
  }
  func layDown() {
    print("layDown")
  }
  func shake() {
    print("shake")
  }
}


let bobby: Dog = Dog()
bobby.color
bobby.color = "Gray"
bobby.color
bobby.sit()

let tory = Dog()
tory.color = "Brown"
tory.layDown()


/*:
 ---
 ### Question
 - 자동차 클래스 정의 및 객체 생성하기
 ---
 */
/*
 자동차 클래스
 - 속성: 차종(model), 연식(model year), 색상(color) 등
 - 기능: 운전하기(drive), 후진하기(reverse) 등
 */
class carModel {
    var model: String
    var year: Int
    var color: String
    
    init(model: String, year: Int, color: String) {
        self.model = model
        self.year = year
        self.color = color
    }
    
    func drive(){
        print("운전")
    }
    func reverse(){
        print("후진")
    }
}

var aaa = carModel(model: "sonata", year: 1990, color: "blue")





/*:
 ---
 ### Answer
 ---
 */
class Car {
  let model = "Palisade"
  let modelYear = 2019
  let color = "Cream White"
  
  func drive() {
    print("전진")
  }
  func reverse() {
    print("후진")
  }
}

let car = Car()
car.drive()
car.reverse()



//: [Next](@next)
