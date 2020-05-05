//: [Previous](@previous)
/*:
 # Optionals
 */
/*:
 ---
 ### Question
 - 값이 0인 것과 없는 것의 차이는?  (Empty vs Valueless)
 ---
 */

















/*:
 ---
 ## Optional
 * Optional 은 값이 없을 수 있는(absent) 상황에 사용
 * Objective-C 에는 없는 개념
 * 옵셔널 타입은 2가지 가능성을 지님
   - 값을 전혀 가지고 있지 않음
   - 값이 있으며, 그 값에 접근하기 위해 옵셔널을 벗겨(unwrap)낼 수 있음
 ---
 */


let possibleNumber = "123"
var convertedNumber = Int(possibleNumber) //**옵셔널로 나오는 이유는 "123"이 아니고 "가나다"일 수도 있기 때문에 값이 있을수도 없을 수도 있기때문임
type(of: convertedNumber)

//type(of: Int("123"))
//type(of: Int(3.14))
//type(of: Int(3))




/*
 Optional Type Declaration
 
 var <#variable name#>: <#Type?#>
 var <#variable name#>: <#Optional<Type>#>
 */

var optionalType1: String?
var optionalType2: Optional<Int>

type(of: optionalType1)
optionalType2


// Valueless state - nil

var optionalIntInit = Optional<Int>(0)
var optionalInt: Int? = 0
type(of: optionalInt)

optionalInt = nil
optionalInt


// Optional <-> NonOptional

//var nonOptional1 = nil 타입지정 안되므로 에러
//var nonOptional2: Int = nil 타입지정 했어도 옵셔널 아니므로 nil값이 못들어가므로 에러
//var nonOptionalType: Int = optionalInt


//optionalInt = 10
//optionalInt = 100
//print(optionalInt)


// Optional -> NonOptional (X)
// Optional <- NonOptional (O)

/*:
 ---
 ### Question
 - Optional 헤더 살펴보기
 ---
 */


/*:
 ---
 ## Optional Biding and Forced Unwrapping
 ---
 */

if convertedNumber != nil {
  print("convertedNumber contains some integer value.")
  //  print("convertedNumber has an integer value of \(convertedNumber).")
}

/*:
 ---
 ### Optional Binding
 ---
 */
print("\n---------- [ Optional Binding ] ----------\n")
/* 옵셔널이 아닌 상태에서 아래 구문을 쓰면 오류가 남. ( let a = 1, if let num = a {} 하면 에러가 남.)
 if let <#nonOptional#> = <#OptionalExpression#> {
   <#Code#>
 }
 while let <#nonOptional#> = <#OptionalExpression#> {
   <#Code#>
 }
 guard let <#nonOptional#> = <#OptionalExpression#> else {
   <#Code#>
 }
 */


let nilValue: String? = nil
let someValue = "100"

if let number = Int(someValue) {
  print("\"\(someValue)\" has an integer value of \(number)")
} else {
  print("Could not be converted to an integer")
}



// Optional Binding - let vs var

var optionalStr: String? = "Hello, Optional"

// let
if let optionalStr = optionalStr {
//  optionalStr += "😍"
  optionalStr
} else {
  "valueless string"
}

// var
if var str = optionalStr {
  str += "😍"
  str
}



// 여러 개의 옵셔널 바인딩과 불리언 조건을 함께 사용 가능
if let firstNumber = Int("4"),
  let secondNumber = Int("42"),
  firstNumber < secondNumber,
  secondNumber < 100 {
  print("\(firstNumber) < \(secondNumber) < 100")
}

// 위와 동일한 동작
if let firstNumber = Int("4") {
  if let secondNumber = Int("42") {
    if firstNumber < secondNumber, secondNumber < 100 {
      print("\(firstNumber) < \(secondNumber) < 100")
    }
  }
}


/*:
 ---
 ### Forced Unwrapping
 ---
 */
/*
 let nonOptional = <#OptionalExpression!#>
 */

print("\n---------- [ Forced Unwrapping ] ----------\n")

if convertedNumber != nil {
//  print("convertedNumber has an integer value of \(convertedNumber).")
  print("convertedNumber has an integer value of \(convertedNumber!).")
}

//print(convertedNumber)
print(convertedNumber!)


// Forced unwrap of nil value

convertedNumber = nil
convertedNumber
//convertedNumber!


/*:
 ## IUO (Implicitly Unwrapped Optionals)
 */

let possibleString: String? = "An optional string."
//let forcedString: String = possibleString  // Error
let forcedString: String = possibleString!
type(of: possibleString)
type(of: forcedString)


var assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString
let stillOptionalString = assumedString
type(of: assumedString)
type(of: implicitString)
type(of: stillOptionalString)

//print(assumedString)
print(assumedString!)

//assumedString = nil
//print(assumedString!)


/*
 - 추후 어느 순간에서라도 nil 이 될 수 있는 경우에는 이 것을 사용하지 말아야 함
 - nil value 를 체크해야 할 일이 생길 경우는 일반적인 옵셔널 타입 사용
 - 프로퍼티 지연 초기화에 많이 사용
 */


/*:
 ## Nil-coalescing Operator
 */

print("\n---------- [ Nil-coalescing ] ----------\n")
//기본값을 가지는 옵셔널 바인딩
optionalStr = nil

var result = ""
if optionalStr != nil { /*nil이 아닌게 확실하니까 강제로 벗겨서 집어넣어라*/
   result = optionalStr!
} else {
   result = "This is a nil value"
}
//print(optionalStr)
print(result)


let anotherExpression = optionalStr ?? "This is a nil value"
//print(optionalStr)
print(anotherExpression)


let optionalInteger: Int? = 100
let anotherExpression2 = optionalInteger ?? -1
print(anotherExpression2)


// 어디에 쓰일 수 있을까요?
// Example

let defaultColorName = "red"
var userDefinedColorName: String?

var colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)

/*:
 ---
 ### Question
 - isTrue ? a : b   와의 차이
 - optionalStr ?? "This is a nil value" 를 3항 연산자로 바꿔보기
 ---
 */


/*:
 ## Optional Chaining
 */

print("\n---------- [ Optional Chaining ] ----------\n")
//
let greeting: [String: String] = [
  "John": "Wassup",
  "Jane": "Morning",
  "Edward": "Yo",
  "Tom": "Howdy",
  "James": "Sup"
]

print(greeting["John"]) //딕셔너리에서 값을 꺼낼때는 옵셔널로 나옴. 키값이 있을수도 없을수도 있기때문에
print(greeting["John"]?.count) // 앞에놈이 옵셔널이면 뒤에 명령어 붙인 값도 전부 옵셔널이 됨.
print(greeting["NoName"])

// Optional Chaining
print(greeting["John"]?.lowercased().uppercased())
print(greeting["Alice"]?.lowercased().uppercased())

// Optional Binding
if let greetingValue = greeting["John"] {
  print(greetingValue.lowercased().uppercased())
}

/*:
 ---
 ### Question
 - 아래 두 종류 옵셔널의 차이점이 무엇일까요?
 ---
 */

print("\n---------- [ ] ----------\n")

var optionalArr1: [Int]? = [1,2,3] //배열 자체. 엘리먼트로 nil값을 넣을 수 없음.
var optionalArr2: [Int?] = [1,2,3] //엘리먼트에 nil값 넣을 수 있음.
//

var arr1: [Int]? = [1,2,3]
//arr1.append(nil)
//arr1 = nil

print(arr1?.count)
print(arr1?[1])


var arr2: [Int?] = [1,2,3]
//arr2.append(nil)
//arr2 = nil

//print(arr2.count)
//print(arr2[1])
//print(arr2.last)


/*:
 ---
 ## Optional Function Types
 ---
 */
print("\n---------- [ Optional Function ] ----------\n")

var aClosure: (() -> Int?)? = {
  return 10
}

type(of: aClosure)
print(aClosure)
print(aClosure?())

aClosure?()
aClosure!()

aClosure = nil
aClosure?()
//aClosure!()



/*:
 ---
 ### Question
 - 아래 내용 참고하여 함수 정의
 ---
 */
/*
 2개의 정수를 입력받아 Modulo 연산(%)의 결과를 반환하는 함수를 만들되
 2번째 파라미터와 결과값의 타입은 옵셔널로 정의.
 두 번째 파라미터 입력값으로 nil 이나 0이 들어오면 결과로 nil을 반환하고, 그 외에는 계산 결과 반환
 
 func calculateModulo(op1: Int, op2: Int?) -> Int? {
 }
 */



/*:
 ---
 ### Answer
 ---
 */
// OptionalStr ?? "This is a nil value" 를 3항 연산자로 바꿔보기
let answer = optionalStr != nil ? optionalStr! : "This is a nil value"




// 2개의 정수를 입력받아 Modulo 연산(%)의 결과를 반환하는 함수
func calculateModulo(op1: Int, op2: Int?) -> Int? {
  guard let op2 = op2, op2 != 0 else { return nil }
  let a = op1 % op2
  return a
}

calculateModulo(op1: 10, op2: 4)
calculateModulo(op1: 39, op2: 5)



//: [Next](@next)
