//: [Previous](@previous)
/*:
 ---
 # Tuples
 ---
 */
/*:
 ---
 ## Unnamed Tuple
 ---
 */
let number: Int = 10

let threeNumbers: (Int, Int, Int) = (1, 2, 5)
type(of: threeNumbers)

threeNumbers

threeNumbers.0
threeNumbers.1
threeNumbers.2


var threeValues: (Int, Double, String) = (10,  100.0,  "이름")
type(of: threeValues)

threeValues

threeValues.0 = 5
threeValues


/*:
 ## Decomposition
 */

let numbers = threeNumbers
numbers
numbers.0
numbers.1


let (first, second, third) = threeNumbers
first
second


/* wildcard pattern: 앞에거 필요없고 뒤에 두개만 필요한 경우. 필요없는 값은 언더바로 대체해도 됨. 구지 언더바를 쓰는 이유는 만약 사용하지 않는 변수가 입력되지 않을 경우 오류가 발생할 수 도 있기 때문임.*/

let (_, second1, third1) = threeNumbers
second1
third1


/*:
 ---
 ## Named Tuple
 ---
 */

let iOS = (language: "Swift", version: "4")

//let iOS: (language: String, version: String) = (language: "Swift", version: "4")
//let iOS: (language: String, version: String) = ("Swift", "4")
//let iOS = (language: "Swift", version: "4")

iOS.0
iOS.1

iOS.language
iOS.version

// MARK: 반환타입

func 튜플(a: Int, b: (Int, Int)) -> (first: Int, second: Int) {
  return (a + b.0, a + b.1)
}

let result = 튜플(a: 10, b: (20, 30))
result.first
result.second

/*:
 ## Comparison Operators
 * Tuple 은 7개 미만 요소에 대한 비교 연산자가 포함되어 있음
 * 7개 이상의 요소를 비교하기 위해서는 비교 연산자를 직접 구현해야 함
 */
//var something1: (Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6)
//var something2: (Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6)
//something1 == something2

//var something3: (Int, Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6,7)
//var something4: (Int, Int, Int, Int, Int, Int, Int) = (1,2,3,4,5,6,7)
//something3 == something4


// 다음의 비교 결과는?
(1, "zebra") < (2, "apple")   //
(3, "apple") > (3, "bird")    //
("3.14", 99) > ("1.99", 1)    //
("blue", 1) > ("bluesky", -1) //
(4, "dog") == (4, "dog")      //

/*
 Q. 다음 튜플 연산에 대한 결과는?
 
 - ("일", 1) > ("이", 2.0) 일 이 문자상 자음2개 모음1개로 더 많으므로 참
 - (1, "zebra") < ("2", "apple") 숫자와 문자를 비교하려하므로 오류 발생
 - ("blue", false) < ("purple", true) 뒤에 참 거짓은 크기 비교가 불가하여 오류 발생
 */



/*:
 ---
 ## Tuple Matching
 ---
 */

let somePoint = (1, 1)

switch somePoint {
case (0, 0):
  print("\(somePoint) is at the origin")
case (_, 0):
  print("\(somePoint) is on the x-axis")
case (0, _):
  print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
  print("\(somePoint) is inside the box")
default:
  print("\(somePoint) is outside of the box")
}



/*:
 ## Dictionary Enumeration
 */

let fruits = ["A": "Apple", "B": "Banana", "C": "Cherry"]

for (key, value) in fruits {
  print(key, value)
}
print()

//for element in fruits {
//  // 어떤 식으로 출력해야 할까요?
//}


//: [Next](@next)
