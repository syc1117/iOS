//: [Previous](@previous)
/*:
 # Literals & Types
 * 리터럴
   - 소스코드에서 고정된 값으로 표현되는 문자 (데이터) 그 자체
   - 정수 / 실수 / 문자 / 문자열 / 불리언 리터럴 등
 */

/*:
 ---
 ## Numeric Literals
 ---
 */
var signedInteger = 123
signedInteger = +123
signedInteger = -123
type(of: signedInteger)

let decimalInteger = 17
let binaryInteger = 0b1000
type(of: binaryInteger)

let octalInteger = 0o21
let hexadecimalInteger = 0x11

var bigNumber = 1_000_000_000
bigNumber = 000_001_000_000_000
bigNumber = 0b1000_1000_0000
bigNumber = 0xAB_00_FF_00_FF

/*:
 ---
 ## Integer Types
 *  8-bit : Int8, UInt8
 * 16-bit : Int16, UInt16
 * 32-bit : Int32, UInt32
 * 64-bit : Int64, UInt64
 * Platform dependent : Int, UInt (64-bit on modern devices)
 ---
 */
//기본 Int 크기는 컴퓨터 성능 1word 에 따라 달라짐(CPU, RAM) 현재 기종이 64bit면 Int64가 기본이 됨.
var integer = 123
integer = -123
type(of: integer)

var unsignedInteger: UInt = 123
type(of: unsignedInteger)


MemoryLayout<Int>.size
Int.max   // 2^63 - 1
Int.min   // -2^63

MemoryLayout<UInt>.size
UInt.max  // 2^64 -1 : 0부터 시작이기 때문에 -1
UInt.min  // 0

MemoryLayout<Int8>.size
Int8.max // 2^7 - 1
Int8.min // -2^7

MemoryLayout<UInt8>.size
UInt8.max // 2^8 - 1
UInt8.min // 0

MemoryLayout<Int16>.size
Int16.max // 2^15 -1
Int16.min // -2^15

MemoryLayout<UInt16>.size
UInt16.max // 2^16 -1
UInt16.min // 0

MemoryLayout<Int32>.size
Int32.max // 2^31 -1
Int32.min // -2^31

MemoryLayout<UInt32>.size
UInt32.max // 2^32 -1
UInt32.min

MemoryLayout<Int64>.size
Int64.max // 2^63 -1
Int64.min // -2^63

MemoryLayout<UInt64>.size
UInt64.max   // 2^63 - 1
UInt64.min // -2^63
print(UInt64.max)



/*:
 ---
 ### Question
 - UInt에 음수를 넣으면?
 - Int8 에 127 을 초과하는 숫자를 넣으면?
 - Int 에 Int32.max ~ Int64.max 사이의 숫자를 넣었을 경우 생각해야 할 내용은?
 ---
 */

//1. let q1: UInt8 = -1

//2. let q2: Int8 = Int8.max + 1
//3. let q2: Int8 = 127 + 1
//let q2 = Int8(127 + 1)
//3번과 4번중에 에러가 나는 것은 무엇이고 각각 에러가 왜 나고 안나는지 설명해보기

Int32.max
Int64.max

let q3 = Int(Int32.max) + 1 //기기 스펙에 따라서 오류가 날 수 있는지 여부
//Int32.max + 1
//Int64.max + 1


/*:
 ---
 ## Overflow Operators
 ---
 */

// 아래 각 연산의 결과는?

// Overflow addition
//var add: Int8 = Int8.max + 1
var add: Int8 = Int8.max &+ 1

Int8.max &+ 1 // = Int8.min
Int32.max &+ 1 // = Int32.min
Int64.max &+ 1 // = Int64.min


// 01111111 = Int8.max 을 더하면 10000000이 되고 이는 Int8.min임
// 10000000 = Int8.min (앞에 1이 부호 -를 의미하기때문에 이런일이 발생함)


// Overflow subtraction
//var subtract: Int8 = Int8.min - 1
var subtract: Int8 = Int8.min &- 1

Int8.min &- 1  // Int8.max
Int32.min &- 1 // Int32.max
Int64.min &- 1 // Int64.max

// 10000000
// 01111111


// Overflow multiplication
//var multiplication: Int8 = Int8.max * 2
var multiplication: Int8 = Int8.max &* 2

Int8.max &* 2
Int32.max &* 2
Int64.max &* 2

//결과값 전부 -2



/*:
 ## Floating-point Literal
 */
var floatingPoint = 1.23 //소수점은 Double 타입을 쓴다 정도만 알면 됨.
floatingPoint = 1.23e4
floatingPoint = 0xFp3
type(of: floatingPoint)

var floatingPointValue = 1.23 //Double 8바이트 엄청 긺
type(of: floatingPointValue)

var floatValue: Float = 1.23 // Float 4바이트 짦음
type(of: floatValue)

MemoryLayout<Float>.size
Float.greatestFiniteMagnitude   // FLT_MAX
Float.leastNormalMagnitude   // FLT_MIN

MemoryLayout<Double>.size
Double.greatestFiniteMagnitude   // DBL_MAX
Double.leastNormalMagnitude   // DBL_MIN


/***************************************************
 Double - 최소 소수점 이하 15 자리수 이하의 정밀도
 Float - 최소 소수점 이하 6 자리수 이하의 정밀도
 부동 소수점(소수점 이동하므로 표현 범위가 넓음)이므로 소수점 이하의 정밀도는 변경 될 수 있음
 ***************************************************/

/*:
 ---
 ## Boolean Literal
 ---
 */
var isBool = true
type(of: isBool)

isBool = false
//isBool = False
//isBool = 1
//isBool = 0


/*:
 ---
 ## String Literal
 ---
 */
let str = "Hello, world!"
type(of: str)

let str1 = ""
type(of: str1)

var language: String = "Swift"

/*:
 ---
 ## Character Literal
 ---
 */

var nonCharacter = "C"
type(of: nonCharacter)

var character: Character = "C"
type(of: character)

MemoryLayout<String>.size
MemoryLayout<Character>.size


//character = ' '
//character = ""
//character = "string"


let whiteSpace = " "
type(of: whiteSpace)


/*:
 ---
 ## Typealias
 - 문맥상 더 적절한 이름으로 기존 타입의 이름을 참조하여 사용하고 싶을 경우 사용
 ---
 */
// typealias <#type name#> = <#type expression#>

typealias Index = Int

let firstIndex: Index = 0
let secondIndex: Int = 0

type(of: firstIndex)
type(of: secondIndex)


//: [Next](@next)
