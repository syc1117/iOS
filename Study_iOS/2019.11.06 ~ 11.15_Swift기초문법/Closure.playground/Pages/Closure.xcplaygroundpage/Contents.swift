//: [Previous](@previous)
/*:
 # closure
 - 코드에서 사용하거나 전달할 수 있는 독립적인 기능을 가진 블럭
 - 함수도 클로저의 일종
 */
/*
 미지원 : Fortran, Pascal, Java 8버전 미만, C++11 버전 미만 등
 지원 : Swift, Objective-C, Python, Java 8 이상, C++11 이상, Javascript 등
 
 언어마다 조금씩 특성이 다름
 다른 프로그래밍 언어의 Lambda(람다 - 익명 함수), Block과 유사
 Lambda ⊃ Closure
 */


/*
 전역(Global) 함수와 중첩(Nested) 함수는 사실 클로저의 특수한 예에 해당.
 클로저는 다음 3가지 중 한 가지 유형을 가짐
  
 - Global functions: 이름을 가지며, 어떤 값도 캡쳐하지 않는 클로저
 - Nested functions: 이름을 가지며, 감싸고 있는 함수의 값을 캡쳐하는 클로저
 - Closure: 주변 문맥(Context)의 값을 캡쳐할 수 있으며, 간단한 문법으로 쓰여진 이름 없는 클로저
 */

//: ## Global functions
print("\n---------- [ Global ] ----------\n")
//아래와 같이 어디에서나 사용할 수 있는 함수
print(1)
max(1, 2)
func globalFunction() { }


//: ## Nested functions
print("\n---------- [ Nested ] ----------\n")
//중첩 함수
// 캡쳐는 나중에 다시 다룰 내용이므로 가볍게 받아들일 것

func outsideFunction() -> () -> () { // () -> () 이 한 세트이고 이것은 인풋 아웃풋 없는 함수를 반환하겠다는 것. 뒤에 return에 함수가 들어감.
  var x = 0
  func nestedFunction() {
    x += 1    // 그 자신의 함수가 가지지 않은 값을 사용
    print(x)
  }
  return nestedFunction
}
let nestedFunction = outsideFunction()
nestedFunction()
nestedFunction()
nestedFunction()


//: ## Closure
/*
 Closure Expression Syntax
 
 { <#(parameters)#> -> <#return type#> in
   <#statements#>
 }
 */

print("\n---------- [ Basic ] ----------\n")

func aFunction() {
  print("This is a function.")
}
aFunction()

({
  print("This is a closure.")
})()



print("\n---------- [ Save closure to variable ] ----------\n")

// 클로저를 변수에 담아 이름 부여 가능
let closure = {
  print("This is a closure.")
}
closure()


// 함수도 변수로 저장 가능
var function = aFunction
function()


// 같은 타입일 경우 함수나 클로저 관계없이 치환 가능
function = closure
function()



print("\n---------- [ Closure Syntax ] ----------\n")

// 파라미터 + 반환 타입을 가진 함수
func funcWithParamAndReturnType(_ param: String) -> String {
  return param + "!"
}
print(funcWithParamAndReturnType("function"))



// 파라미터 + 반환 타입을 가진 클로저
// Type Annotation
let closureWithParamAndReturnType1: (String) -> String = { param in
  return param + "!"
}
print(closureWithParamAndReturnType1("closure"))

// Argument Label은 생략. 함수의 Argument Label을 (_)로 생략한 것과 동일


// 파라미터 + 반환 타입을 가진 클로저
let closureWithParamAndReturnType2 = { (param: String) -> String in
  return param + "!"
}
print(closureWithParamAndReturnType2("closure"))


// 파라미터 + 반환 타입을 가진 클로저
// Type Inference
let closureWithParamAndReturnType3 = { param in  //파라미터 타입지정과 반환값 타입지정이 필요 없는 이유: "!"문자와 연산이 되는 파라미터가 당연히 String이고 String간의 연산 결과가 String이라는 것은 당연한 것이므로 컴파일러가 추론함./
  param + "!"
}
print(closureWithParamAndReturnType3("closure"))




/*:
 ---
 ### Question
 - 문자열을 입력받으면 그 문자열의 개수를 반환하는 클로져 구현
 - 숫자 하나를 입력받은 뒤 1을 더한 값을 반환하는 클로져 구현
 ---
 */
// 1번 문제 예.   "Swift" -> 5
let clo:(String)->Int = {a in return a.count}
clo("swift")

// 2번 문제 예.   5 -> 6
let clo2 = { a in a + 1 }

clo2(5)


/*:
 ---
 ### Closure를 쓰는 이유?
 ---
 */
/*
 - 문법 간소화 / 읽기 좋은 코드
 - 지연 생성 : 미리 생성이 아니고 꼭 필요할 때 생성
 - 주변 컨텍스트의 값을 캡쳐하여 작업 수행 가능 : 중첩함수, 바깥 변수 캡처해서 사용
*/


/*:
 ## Syntax Optimization
 */
/*
 Swift 클로저 문법 최적화
 - 문맥을 통해 매개변수 및 반환 값에 대한 타입 추론 : 연산 자체에서 타입정의가 이미 되어버린다고 판단 할 수 있는 경우( a +  "!", 에서 a와 반환값을 String으로 추론가능함.)
 - 단일 표현식 클로저에서의 반환 키워드 생략
 - 축약 인수명
 - 후행 클로저 문법
 */

print("\n---------- [ Syntax Optimization ] ----------\n")

// 입력된 문자열의 개수를 반환하는 클로저를 함수의 파라미터로 전달하는 예
func performClosure(param: (String) -> Int) { //param이 값이 아닌 함수를 받는 것. 따라서 저기에는 함수가 들어가야함.
  param("Swift")
}

performClosure(param: { (str: String) -> Int in
  return str.count
})

performClosure(param: { (str: String) in
  return str.count //count 메서드를 통해 반환타입이 인트라는 사실을 컴파일러가 추론가능함.
})

performClosure(param: { str in
  return str.count // 맨 위 함수에서 "Swift"를 넣어놨으므로 파라미터 타입 생략이 가능함.
})

performClosure(param: {
  return $0.count //반환타입 지정 명령어 생략으로 return도 같이 생략 가능함
})

performClosure(param: {
  $0.count //파라미터가 가장 마지막일 경우 생략 가능함. 여기서는 처음이자 마지막이므로 생략.
})

performClosure(param: ) {
  $0.count
}

performClosure() { //****중요: 이렇게 끝까지 막줄일 수 있는 이유는 performClosure에서 param: (String) -> Int 를 이미 선언해놓았기 때문임
  $0.count
}

performClosure { $0.count }





/*:
 ## Inline closure
 - 함수의 인수(Argument)로 들어가는 클로저
 */
print("\n---------- [ Inline ] ----------\n")


func closureParamFunction(closure: () -> Void) {
  closure()
}
func printFunction() {
  print("Swift Function!")
}
let printClosure = {
  print("Swift Closure!")
}

closureParamFunction(closure: printFunction)
closureParamFunction(closure: printClosure)

// 인라인 클로저 - 변수나 함수처럼 중간 매개체 없이 사용되는 클로저
closureParamFunction(closure: {
  print("Inline closure - Explicit closure parameter name")
})


/*:
 ## Trailing Closure
 - 함수의 괄호가 닫힌 후에도 인수로 취급되는 클로저
 - 함수의 마지막 인수(Argument)에만 사용 가능하고 해당 인수명은 생략
 - 하나의 라인에 다 표현하지 못할 긴 클로져에 유용
 */
print("\n---------- [ Trailing ] ----------\n")

// 후위 또는 후행 클로저
// closureParamFunction { <#code#> }

closureParamFunction(closure: {
  print("Inline closure - Explicit closure parameter name")
})
closureParamFunction() {
  print("Trailing closure - Implicit closure parameter name")
}
closureParamFunction {
  print("Trailing closure - Implicit closure parameter name")
}


//맨 마지막, 아래 예에서는 closure2, 파라미터는 파라미터명 생략 가능함.
func multiClosureParams(closure1: () -> Void, closure2: () -> Void) {
  closure1()
  closure2()
} // 이 함수는 인풋 아웃풋이 없는 함수를 변수로 받을 수 있는 함수

multiClosureParams(closure1: {
  print("inline")
}, closure2: {
  print("inline")
}) //함수에 두 가지(인풋 아웃풋)이 없는 클로저 2개를 넣은 것. 함수명(x: 1, y: 2)와 같은 형태

multiClosureParams(closure1: {print("inline")}) {print("trailing")}
//마지막 인수명(파라미터명)을 생략하고 사용하는 경우. 함수명(x: 1) y 와 같은 형태



/*:
 ---
 ### Question
 - 정수를 하나 입력받아 2의 배수 여부를 반환하는 클로져
 - 정수를 두 개 입력 받아 곱한 결과를 반환하는 클로져
 ---
 */
//아래에서 (a: Int) -> Bool 는 생략할 수 없는데 이는 컴파일러 버전마다 다르기도 하고 사실 협업과정에서 이정도는 보여주는 것이 좋음.
let boolClosure = { (a: Int) -> Bool in
    a % 2 == 0 // a.isMultiple(of: 2) 같은 것임
}

boolClosure(3)

let multiClosure: (Int, Int) -> Int = {$0 * $1} // 곱셈이 되는 변수가 인트, 더블, 플롯 다 되기때문에 곱셈만가지고 인트라고 추론할 수 없기 때문에. 곱셈이 안되는 것이 들어오는 경우를 생각하는 것이 아님. 아예 못들어오기 때문임.


/*:
 ---
 ### Answer
 ---
 */
print("\n---------- [ Answer ] ----------\n")

/// 문자열을 입력받으면 그 문자열의 개수를 반환하는 클로져 구현

// 1단계 - 함수로 생각
func stringCount(str: String) -> Int {
  return str.count
}
print(stringCount(str: "Swift"))

// 2단계 - 클로저로 변형
let stringCount = { (str: String) -> Int in
  return str.count
}
stringCount("Swift")

// 3단계 - 문법 최적화
let stringCount2: (String) -> Int = { $0.count }



/// 숫자 하나를 입력받은 뒤 1을 더한 값을 반환하는 클로져 구현
let addOne = { (num: Int) -> Int in
  return num + 1
}
addOne(5)


/// 정수를 하나 입력받아 2의 배수 여부를 반환하는 클로져
let isEven = { (number: Int) -> Bool in
  return number % 2 == 0
}
// Optimization
let isEven2 = { $0 % 2 == 0 }
isEven(6)
isEven(5)


/// 정수를 두 개 입력받아 곱한 결과를 반환하는 클로져
let multiplyTwoNumbers = { (op1: Int, op2: Int) -> Int in
  return op1 * op2
}
// Optimization
let multiplyTwoNumbers2: (Int, Int) -> Int = { $0 * $1 }

multiplyTwoNumbers(20, 5)
multiplyTwoNumbers(5, 10)
multiplyTwoNumbers2(5, 10)




//: [Next](@next)
