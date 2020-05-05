//: [Previous](@previous)


import UIKit

class UIViewController {
  var color = UIColor.black
  
  func draw() {
    print("draw shape")
  }
}

class NextViewController: UIViewController {
  var cornerRadius = 0.0
  override var color: UIColor {
    get { return .white }
    set { }
  }
  
  override func draw() {
    print("draw rect")
  }
}

class Triangle: UIViewController {
  override func draw() {
    print("draw triangle")
  }
}

/***************************************************
 Shape
  - Rectangle
  - Triangle
 모두 draw() 오버라이드
 ***************************************************/


/*:
 ---
 ## Upcasting
 ---
 */
print("\n---------- [ Upcasting ] ----------\n")

/*
 업 캐스팅
 - 상속 관계에 있는 자식 클래스가 부모 클래스로 형 변환하는 것
 - 업캐스팅은 항상 성공하며 as 키워드를 사용
 (자기 자신에 대한 타입 캐스팅도 항상 성공하므로 as 키워드 사용)
 */


let rect = NextViewController()
rect.color
rect.cornerRadius

let a = rect as UIViewController
a.color

(rect as UIViewController).color
//(rect as Shape).cornerRadius
(rect as NextViewController).color
(rect as NextViewController).cornerRadius
//rect as Shape에서 각 오브젝트의 값들은 rect의 것들이 반환됨. 주체가 rect이기 때문임. rect를 형변환하는 것임.


let segueDestination: UIViewController = NextViewController()
segueDestination.color

let x = (segueDestination as! NextViewController)

type(of: segueDestination)   //

//자식 타입 -> 부모 타입 (o)
//부모 타입 -> 자식 타입 (x)

//자식 타입  -> 부모 타입: 자식 타입은 부모 타입이 가지고 있는 오브젝트를 반드시 가지고 있음
let shape: UIViewController = NextViewController()
shape.color
shape.draw()

//부모 타입 -> 자식 타입: 부모 타입은 자식 타입이 가지고 있는 오브젝트를 가지고 있지 않는 경우가 있을 수 있기 때문에 사용시 오류가 발생함.

//let rec: Rectangle = Shape()

//upcastedRect.color
//upcastedRect.cornerRadius

//(upcastedRect as Shape).color
//(upcastedRect as Rectangle).color

//부모에서 자식으로 as로 접근은 안됨: 자식이 여러개일 수 있기 때문에 정확히 어떤건지 확신할 수 없기 때문임.
/*:
 ---
 ## Downcasting
 ---
 */
print("\n---------- [ Downcasting ] ----------\n")

/***************************************************
 다운 캐스팅
 - 형제 클래스나 다른 서브 클래스 등 수퍼 클래스에서 파생된 각종 서브 클래스로의 타입 변환 의미
 - 반드시 성공한다는 보장이 없으므로 옵셔널. as? 또는 as! 를 사용
 ***************************************************/


let shapeRect: Shape = Rectangle()
var downcastedRect = Rectangle()

shapeRect.color
shapeRect.draw()

downcastedRect.color

if let x = shapeRect as? Rectangle{
    x.color}



//downcastedRect = shapeRect // 오류 이유:
//downcastedRect = shapeRect as Rectangle

//downcastedRect: Rectangle = shapeRect as? Rectangle  //
//downcastedRect = shapeRect as! Rectangle  //

//as? : 강제 타입 변환 시도. 변환이 성공하면 Optional 값을 가지며, 실패 시에는 nil 반환
//as! : 강제 타입 변환 시도. 성공 시 언래핑 된 값을 가지며, 실패 시 런타임 에러 발생



//Q. 아래 value 에 대한 Casting 결과는?
let value = 1
let value2 = Float(value)
type(of: value2)
//(value as Float) is Float   // (value as Float)에서 오류남. Int와 Float는 부모 형제 관계가 아니기 때문에 변환이 이루어지지 않아 오류가 발생함.
//(value as? Float) is Float  // (value as Float)값이 nil이므로 거짓반환
//(value as! Float) is Float  // 런타임 오류 발생. 인트를 플롯으로 강제 변환이 안되어서 오류가 발생함.


/*:
 ---
 ## Type Check Operator
 ---
 */
let shape2 = Shape()
let rectangle = Rectangle()
let triangle = Triangle()

let list = [shape2, rectangle, triangle]  //공통된 부모클래스를 타입으로 가짐.

//class Shape {
//  var color = UIColor.black
//
//  func draw() {
//    print("draw shape")
//  }
//}
//
//class Rectangle: Shape {
//  var cornerRadius = 0.0
//  override var color: UIColor {
//    get { return .white }
//    set { }
//  }
//
//  override func draw() {
//    print("draw rect")
//  }
//}
//
//class Triangle: Shape {
//  override func draw() {
//    print("draw triangle")
//  }
//}

/*:
 ---
 ### Question
 - 아래 for 문에 대한 실행 결과는?
 ---
 */
for elem in list {
  if elem is Shape {
    print("shape instance")
  } else if elem is Rectangle {
    print("rect instance")
  } else if elem is Triangle {
    print("triangle instance")
  }
}



print("\n---------- [ ] ----------\n")

// let list: [Shape] = [shape, rectangle, triangle]
for element in list  {
  element.draw()
}





//: [Next](@next)
