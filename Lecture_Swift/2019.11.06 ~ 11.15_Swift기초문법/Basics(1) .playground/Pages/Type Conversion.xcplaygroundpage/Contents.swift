//: [Previous](@previous)
/*:
 # Type Conversion
 */

let height = Int8(5)
let width = 10
//let area = height * width
//print(area)


let h = Int8(12)
let x = 10 * h
//print(x)

/*위 let width 는 이미 인트로 타입지정이 된 상태여서 에러발생하지만 밑의 10 * h에서 10은 아직 타입지정이 안되었기때문에
자동으로 Int8로 상정하고 계산 하게 됨.*/


/*:
 ---
 ## Question
 - 8번째 라인 let area = height * width  부분은 에러가 발생하고
 - 13번째 라인 let x = 10 * h 에서는 에러가 발생하지 않는 이유는?
 ---
 */

let num = 10.1
let floatNum = Float(num)
type(of: floatNum)

let signedInteger = Int(floatNum)
type(of: signedInteger)

let str = String(num)
type(of: str)


let anInteger: Int = -15
let absNum = abs(anInteger) //절대값
type(of: absNum)


//: [Next](@next)
