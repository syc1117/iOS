//: [Previous](@previous)
/*:
 # Function
 - Functions are self-contained chunks of code that perform a specific task
 - 일련의 작업을 수행하는 코드 묶음을 식별할 수 있는 특정한 이름을 부여하여 사용하는 것
 - 유형
   - Input 과 Output 이 모두 있는 것 (Function)
   - Input 이 없고 Output 만 있는 것 (Generator)
   - Input 이 있고 Output 은 없는 것 (Consumer)
   - Input 과 Output 이 모두 없는 것
 */

/*
 func <#functionName#>(<#parameterName#>: <#Type#>) -> <#ReturnType#> {
   <#statements#>
 }
 */
/*:
 ---
 ## Functions without parameters
 ---
 */
print("\n---------- [ Functions without parameters ] ----------\n")

print("Hello, world!")

func hello1() {
  print("Hello, world!")
}

func hello2() -> String {
  return "Hello, world!"
}

hello1()
print(hello2())

/*:
 ---
 ## Functions without return values
 ---
 */
print("\n---------- [ Functions without return values ] ----------\n")

func say(number: Int) {
  print(number)
}

func say(word: String) -> Void {
  print(word)
}

func say(something: String) -> () {
  print(something)
}

say(number: 1)
say(word: "1")
say(something: "1")


/*:
 ---
 ## Functions with params and return values
 ---
 */
print("\n---------- [ Functions with params and return values ] ----------\n")

func greet(person: String) -> String {
  let greeting = "Hello, " + person + "!"
  return greeting
}

greet(person: "Anna")
greet(person: "Brian")



func greetAgain(person: String) -> String {
  return "Hello again, " + person + "!"
}

greetAgain(person: "Anna")



func addNumbers(a: Int, b: Int) -> Int {
  return a + b
}

addNumbers(a: 10, b: 20)
addNumbers(a: 3, b: 5)


/*:
 ---
 ## Omit Return
 ---
 */
func addTwoNumbers(a: Int, b: Int) -> Int {
  a + b
}
addTwoNumbers(a: 1, b: 2)
//함수안에 수식이 한줄밖에 없을경우 리턴 생략가능. 그러나 두줄 세줄 넘어가면 오류발생.

/*:
---
## Function Scope
---
*/
let outside = "outside"
func scope() {
  print(outside)
  let inside = "inside"
  print(inside)
}
scope()
//print(inside)


/*:
 ---
 ## Argument Label
 ---
 */
/*
 func functionName(<#parameterName#>: <#Type#>) {}
 */

func someFunction(firstParam: Int, secondParam: Int) {
  print(firstParam, secondParam)
}
someFunction(firstParam: 1, secondParam: 2)


/*
 func functionName(<#argumentName#> <#parameterName#>: <#Type#>) {}
 */


// Omitting Argument Labels

func someFunction(_ firstParam: Int, secondParam: Int) {
  print(firstParam, secondParam)
}

//someFunction(firstParameterName: 1, secondParameterName: 2)
someFunction(1, secondParam: 2)



// Specifying Argument Labels

func someFunction(argumentLabel parameterName: Int) {
  print(parameterName)
}

someFunction(argumentLabel: 10)


/*:
 ---
 ### Question.
 - Argument Label을 별도로 지정하는 건 어떤 경우인가요
 ---
 */

// argumentLabel 지정 예시
func use(item: String) {
  print(item)
}
use(item: "Macbook")

func speak(to name: String) {
  print(name)
}
speak(to: "Tory")


/*:
 ---
 ### Question
 - 이름을 입력 값으로 받아서 출력하는 함수 (기본 형태)
 - 나이를 입력 값으로 받아서 출력하는 함수 (Argument Label 생략)
 - 이름을 입력 값으로 받아 인사말을 출력하는 함수 (Argument Label 지정)
 ---
 */
// 하단 Answer 참고



/*:
---
## Default Parameter Values
---
*/

func functionWithDefault(
  paramWithoutDefault: Int,
  paramWithDefault: Int = 12
  ) -> Int {
  return paramWithDefault
}

functionWithDefault(paramWithoutDefault: 3, paramWithDefault: 6)
// parameterWithDefault is 6

functionWithDefault(paramWithoutDefault: 4)
// parameterWithDefault is 12



/*:
---
## Variadic Parameters
---
*/
//***파라미터에 들어간 값들이 배열을 형성한다.
func arithmeticAverage(_ x: Double...) -> Double {
  var total = 0.0
  for i in x {
    total+=i
  }
  return total / Double(x.count)
}

arithmeticAverage(1, 2, 3, 4, 5)
arithmeticAverage(3, 8.25, 18.75)

//print(10,20,30,40,50)
//print(1,2,3,4,5,6,7)


//값이 어떤 파라미터에 들어가는 지 구분이 안되면 오류가 나는 것.
//func arithmeticAverage2(_ numbers: Double..., _ last: Double) {
//  print(numbers)
//  print(last)
//}
//
//arithmeticAverage2(1, 2, 3, 5)


func arithmeticAverage3(_ numbers: Double..., and last: Double) {
  print(numbers)
  print(last)
}

arithmeticAverage3(1, 2, 3, and: 5)


/*:
 ---
 ## Nested Functions
 - 외부에는 숨기고 함수 내부에서만 사용할 함수를 중첩하여 사용 가능
 ---
 */
func chooseStepFunction(backward: Bool, value: Int) -> Int{
  func stepForward(input: Int) -> Int {
    return input + 1
  }
  func stepBackward(input: Int) -> Int {
    return input - 1
  }
  
  if backward {
    return stepBackward(input: value)
  } else {
    return stepForward(input: value)
  }
}





var value = 4
chooseStepFunction(backward: true, value: value)
chooseStepFunction(backward: false, value: value)




/*:
 ---
 ### Answer
 ---
 */

func print(name: String) {
  print(name)
}
print(name: "Tory")


func printAge(_ age: Int) {
  print(age)
}
printAge(4)


func sayHello(to name: String) {
  print(name)
}
sayHello(to: "Lilly")

//: [Next](@next)
