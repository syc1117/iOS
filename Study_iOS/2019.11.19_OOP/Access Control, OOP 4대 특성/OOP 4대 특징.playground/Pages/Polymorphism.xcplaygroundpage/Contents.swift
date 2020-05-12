//: [Previous](@previous)
import UIKit
//: - - -
//: # Polymorphism
//: * Overloading
//: * Overriding
//: - - -
//: ## Overloading
/***************************************************
 1. 다른 파라미터 이름
 2. 다른 파라미터 타입
 3. 다른 파라미터 개수
 ***************************************************/

print("\n---------- [ Overloading ] ----------\n")

//오버라이딩을 할 때 사용을 위해 호출하는 방식이 겹치면 에러가 발생하게 됨.
func printParameter() {
  print("No param")
}

//func printParameter() -> String {   // Error
//  print("No param")
//}

func printParameter(param: Int) {
  print("Input :", param)
}

func printParameter(_ param: Int) {
  print("Input :", param)
}

print("=====")
printParameter()
printParameter(param: 1)
printParameter(1)


// ---------

func printParameter(param: String) {
  print("Input :", param)
}

func printParameter(_ param: String) {
  print("Input :", param)
}

func printParameter(name param: String) {
  print("Input :", param)
}

//func printParameter(param name: String) {   // Error
//  print("Input :", name)
//}


print("=====")
printParameter(param: "hello")
printParameter("hello")
printParameter(name: "Hello")


/////////

func printParameter(param: String, param1: String) {
  print("Input :", param, param1)
}

func printParameter(_ param: String, _ param1: String) {
  print("Input :", param, param1)
}

func printParameter(_ param: String, param1: String) {
  print("Input :", param, param1)
}

func printParameter(param: String, _ param1: String) {
  print("Input :", param, param1)
}


print("=====")
printParameter(param: "hello", param1: "world")
printParameter("hello", "world")
printParameter("hello", param1: "world")
printParameter(param: "hello", "world")




//: ## Overriding

print("\n---------- [ Overriding ] ----------\n")

class Shape {
  var title = "Shape"
  var color = UIColor.black
  
  // 변경 불가
  final var lineWidth = 3
  let unit = "cm"
  
  init(color: UIColor) {
    self.color = color
  }
  
  func draw() {
    print("draw shape")
  }
}


let shape = Shape(color: .cyan)
shape.color
shape.draw()


print("\n---------- [ Rectangle ] ----------\n")

class Rectangle: Shape {
  var cornerRadius = 0.0
  
  // 저장 프로퍼티 X 에서는 여기에 오버라이드를 사용할 수 없다. 따라서 값을 변경하고 싶다면 연산프로퍼티 형식으로 사용해야함.
  //  override var color: UIColor  = .green
  
  // 계산 프로퍼티 O
  override var color: UIColor {
    get {
      return super.color //상속 받은 부모 값일때 super를 사용함.
    }
    set {
      super.color = newValue
    }
  }
  
  override var title: String {
    get {
      //      return "Rectangle"
      return super.title + " => Rectangle"
    }
    set {
      super.title = newValue
    }
  }
  
  init(color: UIColor, cornerRadius: Double = 10.0) {
    self.cornerRadius = cornerRadius
    super.init(color: color) // 자식 클래스에서 부모클래스 초기화 메서드를 사용할 때는 뒤에 위치 시켜야 함.
  }
}

let rect = Rectangle(color: UIColor.blue)
rect.color
rect.color = .yellow
rect.color
shape.color

rect.cornerRadius
rect.lineWidth
rect.draw()

shape.title
rect.title



print("\n---------- [ Triangle ] ----------\n")

class Triangle: Shape {
  override func draw() {
    super.draw() //부모가 가진 draw메서드를 먼저 호출하고 나서 뒤에 것을 실행.
    print("draw triangle")
  }
}

let triangle = Triangle(color: .gray)
triangle.title
triangle.lineWidth
triangle.color
//triangle.cornerRadius    //
triangle.draw()



/*:
 ---
 ### Question
 - 아래 문제를 상속을 적용해 해결해보기
 ---
 */
// bark() 메서드를 가진 Dog 클래스를 상속받아 Poodle, Husky, Bulldog 이 서로 다르게 짖도록 구현

class Dog {
  func bark() {
    print("멍멍")
  }
}

class Poodle:Dog {
  override func bark() {
    print("멍멍1")
  }
}

class Husky:Dog {
  override func bark() {
    print("멍멍2")
  }
}

class Bulldog:Dog {
  override func bark() {
    print("멍멍3")
  }
}
/*:
 ---
 ### Answer
 ---
 */
class Dog1 {
  func bark() {
    print("멍멍")
  }
}

class Poodle1: Dog1 {
  override func bark() {
    print("왈왈")
  }
}

class Husky1: Dog1 {
  override func bark() {
    print("으르르")
  }
}

class Bulldog1: Dog1 {
  override func bark() {
    super.bark()
    print("bowwow")
  }
}

// Dog 타입의 객체에 bark 메서드를 실행하라는 메시지 전달
// override 된 경우 해당 메서드를 찾아서 실행

print("\n---------- [ Dog ] ----------")
var dog1: Dog1 = Dog1()
dog1.bark()

print("\n---------- [ Poodle ] ----------")
dog1 = Poodle1()
dog1.bark()

print("\n---------- [ Husky ] ----------")
dog1 = Husky1()
dog1.bark()

print("\n---------- [ Bulldog ] ----------")
dog1 = Bulldog1()
dog1.bark()




//: [Next](@next)
