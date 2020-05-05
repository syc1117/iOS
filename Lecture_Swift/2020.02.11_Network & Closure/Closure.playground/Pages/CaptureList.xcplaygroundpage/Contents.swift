//: [Previous](@previous)
//: # CaptureList
/*:
 ---
 ## Value Type
 ---
 */
print("\n---------- [ Value Type ] ----------\n")

var a = 0
var b = 0
var c = 0
var result = 0


let valueCapture1 = {
  result = a + b + c
  print("내부 값 :", a, b, c, result)
}

(a, b, c) = (1, 2, 3)
result = a + b + c
print("초기 값 :", a, b, c, result)

valueCapture1()

print("최종 값 :", a, b, c, result)
print()


// Capture List : [a, b]

let valueCapture2 = { [a, b] in
  result = a + b + c
  print("내부 값 :", a, b, c, result)
} // --->  a와 b에 대해서 클로저 실행 전에 정의된 값을 보존시킴. 즉, 아래서 a, b값이 각각 1->7, 2->8로 바뀌어있지만 클로져 내부에서는 a, b 값을  1과 7로 못 박아 두는 것임. [a, b] in 을 생략할 경우에는 값이 7, 8로 변경되어 적용됨.

(a, b, c) = (7, 8, 9)
result = a + b + c
print("초기 값 :", a, b, c, result)

valueCapture2()
print("최종 값 :", a, b, c, result)



/*:
 ---
 ## Reference Type
 ---
 */
print("\n---------- [ Reference Type ] ----------\n")

final class RefType {
  var number = 0
}
var x = RefType()
var y = RefType()
print("초기 값 :", x.number, y.number)

let refCapture = { [x] in // stack에 있는 x = RefType()의 주소값을 고정시키는 것으로서, heap에 있는 값 자체에는 아무런 영향을 주지 않음. 그러나 이렇게 했을 경웨 x에 대해서 새로운 x = RefType()를 다시 정의하거나 x에 다른 클래스를 인스턴스화 할 수 없음.
  print("내부 값 :", x.number, y.number)
}
x.number = 5
y.number = 7
print("변경 값 :", x.number, y.number)

refCapture()
print("최종 값 :", x.number, y.number)


/*:
 ---
 ## Binding an arbitrary expression
 ---
 */

print("\n---------- [ binding ] ----------\n")
let captureBinding = { [z = x] in //위에서 선언한 var x = RefType() 에 대해서 x를 z라는 변수명으로 사용하고 싶을 때 사용.
  print(z.number) //  print(x.number)와 같은 결과값을 냄.
}
let captureWeakBinding = { [weak z = x] in // z = x를 선언하면 클로저가 실행되면서 z가 x의 참조카운트를 1 올리게 되는데, 여기서 그 참조카운트를 올리지 않도록 하기 위해 weak을 붙여 사용함.
  print(z?.number ?? 0)
}
let captureUnownedBinding = { [unowned z = x] in
  print(z.number)
}

captureBinding()
captureWeakBinding()
captureUnownedBinding()



//: [Next](@next)
