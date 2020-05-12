//: [Previous](@previous)
/*:
 ---
 ## Access Levels
 * open
 * public
 * internal
 * fileprivate
 * private
 ---
 */
//: [공식 문서](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)
//오픈, 퍼블릭은 접근제한범위가 없는 것
//인터널은 생략되어 있지만 일반적인 형태
//파일 프라이빗은 파일 내부에서만 접근 가능
//프라이빗은 클래스 내부에서만 접근 가능 - (set)을 통해 프라이빗을 set에만 적용할 수도 있음.


/***************************************************
 Open / Public
 ***************************************************/

open class SomeOpenClass {
  open var name = "name"
  public var age = 20
}

public class SomePublicClass {
  public var name = "name"
  var age = 20
}

let someOpenClass = SomeOpenClass()
someOpenClass.name
someOpenClass.age

let somePublicClass = SomePublicClass()
somePublicClass.name
somePublicClass.age

//: ---
/***************************************************
 Internal
 ***************************************************/

class SomeInternalClass {
  internal var name = "name"
  internal var age = 0
}

//class SomeInternalClass {
//  var name = "name"
//  var age = 0
//}


let someInternalClass = SomeInternalClass()
someInternalClass.name
someInternalClass.age

//: ---
/***************************************************
 fileprivate
 ***************************************************/

class SomeFileprivateClass {
  fileprivate var name = "name"
  fileprivate var age = 0
}

let someFileprivateClass = SomeFileprivateClass()
someFileprivateClass.name
someFileprivateClass.age


//: ---

class SomePrivateClass {
  private var name = "name"
  private var age = 0
  
  func someFunction() {
    print(name)
  }
}

//let somePrivateClass = SomePrivateClass()
//somePrivateClass.someFunction()
//somePrivateClass.name
//somePrivateClass.age



/***************************************************
 1. Command Line Tool 로 체크
 2. UIViewController, Int 등 애플 프레임워크의 접근 제한자 확인
 ***************************************************/


/*:
 ---
 ## Nested Types
 * Private  ->  Fileprivate
 * Fileprivate  ->  Fileprivate
 * Internal  ->  Internal
 * Public  ->  Internal
 * Open  ->  Internal
 ---
 */
// 예시
open class AClass {
  // 별도로 명시해주지 않으면 someProperty 는 Internal 레벨
  var someProperty: Int = 0
}


//: [Next](@next)
