//: [Previous](@previous)
/*:
 # Conditional Statements
 */

/*:
 ---
 ## if Statements
 ---
 */
/*
 if <#condition#> {
   <#code#>
 }
 
 if <#condition#> {
   <#statements#>
 } else {
   <#statements#>
 }
 
 - condition 은 Bool 값 (true, false)
 */

// if

var temperatureInFahrenheit = 30

if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
}


// if - else

temperatureInFahrenheit = 40

if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}


// if - else if - else

temperatureInFahrenheit = 90

if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}


// if - else if

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
}



// true && true = true
// true && false = false

// Logical And Operator
if (temperatureInFahrenheit > 0) && (temperatureInFahrenheit % 2 == 0) {
}

// Logical And Operator
if temperatureInFahrenheit > 0, temperatureInFahrenheit % 2 == 0 { // &&랑 같음.
}

// Logical Or Operator
if temperatureInFahrenheit > 0 || temperatureInFahrenheit % 2 == 0 {
}

/*:
 ---
 ### Question
 - if ~ else if   /  if 문을 2개 하는 것과 차이점?
 - if ~ else if 만 있을 때 else 없이 동일하게 처리하려면?
 ---
 */

// if ~ else if   /  if 문을 2개 하는 것과 차이점?

var number = 9
if number < 10 {
  print("10보다 작다")
} else if number < 20 {
  print("20보다 작다")
}

if number < 10 {
  print("10보다 작다")
}
if number < 20 {
  print("20보다 작다")
}



// if ~ else if 만 있을 때 else 없이 동일하게 처리하려면?
number = 25

if number < 10 {
  print("10보다 작다")
} else if number < 20 {
  print("20보다 작다")
} else {
  print("20과 같거나 크다")
}


if number < 10 {
  print("10보다 작다")
} else if number < 20 {
  print("20보다 작다")
} else if number >= 20 {
  print("20과 같거나 크다")
}




/*:
 ---
 ## switch Statements
 ---
 */
/*
 switch <#value#> {
 case <#value 1#>:
     <#respond to value 1#>
 case <#value 2#>,
      <#value 3#>:
     <#respond to value 2 or 3#>
 default:
     <#otherwise, do something else#>
 }
 
 - switch 문은 가능한 모든 사례를 반드시 다루어야 함 (Switch must be exhaustive) 
 */

print("\n---------- [ switch statements ] ----------\n")

let alphabet: Character = "a"

switch alphabet {
case "a":
  print("The first letter of the alphabet")
case "z":
  print("The last letter of the alphabet")
default:
  break
//  print("Some other character")
}


// Without default case : 모든 경우를 다 다뤘을 경우에는 default 없어도 됨.

let isTrue = true
type(of: isTrue)

switch isTrue {
case true:
  print("true")
case false:
  print("false")
}



// Interval Matching

print("\n---------- [ Interval Matching ] ----------\n")

let approximateCount = 30

switch approximateCount {
case 0...50:
  print("0 ~ 50")
case 51...100:
  print("51 ~ 100")
default:
  print("Something else")
}


/*:
 ---
 ### Question
 - 아래의 if - else if - else 문을 switch 문으로 바꿔보세요.
 ---
 */
// 하단 Answer 참고

/*
 if temperatureInFahrenheit <= 32 {
 print("It's very cold. Consider wearing a scarf.")
 } else if temperatureInFahrenheit >= 86 {
 print("It's really warm. Don't forget to wear sunscreen.")
 } else {
 print("It's not that cold. Wear a t-shirt.")
 }
 */




// Compound Cases

// if문은 콤마(,)가 And(&&)연산인 것과 반대로 switch문은 콤마(,)가 Or(||) 연산

let someCharacter: Character = "e"

switch someCharacter {
case "a", "e", "i", "o", "u":
  print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
  print("\(someCharacter) is a consonant")
default:
  print("\(someCharacter) is not a vowel or a consonant")
}



// value binding

// x, y 좌표
let somePoint = (9, 0)

switch somePoint {
case (let distance, 0), (0, let distance):
  print("On an axis, \(distance) from the origin")
default:
  print("Not on an axis")
}


// ***** where clause : 조건에 변수를 사용하고 싶을 때 조건 설정이 안되면 where를 통해 조건 설정을 함.

let anotherPoint = (1, -1)
switch anotherPoint {
case let (x, y) where x == y:
  print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
  print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
  print("(\(x), \(y)) is just some arbitrary point")
}

/*:
 ---
 ### Question
 - 어떤 숫자가 주어졌을 때 짝수인지 홀수인지 출력 (switch의 where 절 이용)
 ---
 */
// 하단 Answer 참고
let a = 2
switch a {
case let x where x.isMultiple(of: 2):
    print("aa")
default: print("bb")
}


// fallthrough: 조건을 위에서 만족해도 나가지 않고 바로 밑의 조건을 한번 더 실행한다.

print("\n---------- [ fallthrough ] ----------\n")
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"

switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
  description += " a prime number, and also"
  fallthrough
default:
  description += " an integer."
}
print(description)



/*:
 ---
 ## Early Exit
 - guard statement
 ---
 */
/*
 if <#condition#> {
 <#code#>
 } else if <#condition#> {
 <#code#>
 }
 - 특정 조건을 만족하면 해당 분기문 실행
 
 guard <#condition#> else {
 <#code#>
 }
 - 조건에 맞지 않으면 바로 종료.
 - 들여쓰기 중첩 방지
 */

func update(age: Int) {
  if 1...100 ~= age {  // ~=는 1 < age < 100
    print("Update")
  }
}

//func update(age: Int) {
//  switch age {
//  case 1...100: print("Update")
//  default: break
//  }
//}

//func update(age: Int) {
//  guard 1...100 ~= age else { return }
//  print("Update")
//}

update(age: -1)
update(age: 2)
update(age: 100)



func someFunction() {
  // ...
  // ...
  
  // if 문의 조건이 맞으면 어떤 코드를 수행할 것
  if Bool.random() {
    // ...
  }

  // gaurd문의 조건을 만족할 때만 다음으로 넘어갈 것
  guard Bool.random() else { return }
  
  // ...
  // ...
}




/*:
 ---
 ### Answer
 ---
 */
print("\n---------- [ Answer ] ----------\n")

// if - else if - else 문을 switch 문으로 바꿔보세요.
switch temperatureInFahrenheit {
case ...32:
  print("It's very cold. Consider wearing a scarf.")
case 86...:
  print("It's really warm. Don't forget to wear sunscreen.")
default:
  print("It's not that cold. Wear a t-shirt.")
}



// 어떤 숫자가 주어졌을 때 짝수인지 홀수인지 출력 (switch의 where 절 이용)
let even = 4
switch even {
case let x where x.isMultiple(of: 2):
  print("\(x)는 짝수")
default:
  print("홀수")
}


//: [Next](@next)
