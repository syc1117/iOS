//: [Previous](@previous)
/*:
 # Practice
 */
/*:
 ---
 ## Conditional Statements
 ---
 */
//
// - 학점을 입력받아 각각의 등급을 반환해주는 함수 (4.5 = A+,  4.0 = A, 3.5 = B+ ...)
func grade(_ score:Double){
    switch score {
      case 4.5: print("A+")
      case 4.0: print("A")
      case 3.5: print("B+")
      case 3.0: print("B")
    default: print("f")
    }
}
grade(4.5)
// - 특정 달을 숫자로 입력 받아서 문자열로 반환하는 함수 (1 = "Jan" , 2 = "Feb", ...)
func month(_ month: Int){
    switch month {
      case 1: print("Jan")
      case 2: print("Feb")
      case 3: print("Mar")
      case 4: print("Apr")
      case 5: print("May")
      case 6: print("June")
      case 7: print("July")
      case 8: print("Aug")
      case 9: print("Sep")
      case 10: print("Oct")
      case 11: print("Nov")
      case 12: print("Dec")
    default: print("Error")
    }
}
month(4)

// - 세 수를 입력받아 세 수의 곱이 양수이면 true, 그렇지 않으면 false 를 반환하는 함수
func booli(_ a: Int, _ b:Int, _ c:Int) -> Bool{
   let result = a * b * c
    if result > 0 { return true
    } else {
        return false
    }
}
booli(10, 5, 20)

//   (switch where clause 를 이용해 풀어볼 수 있으면 해보기)
 func booli2(_ a: Int, _ b:Int, _ c:Int) -> Bool{
   let result = a * b * c
    switch result {
    case let x where x > 0: return true
    case let x where x <= 0: return false
    default: return false
    }
}

booli2(10, 20, 40)


/*:
 ---
 ## Loops
 ---
 */

 /*반복문(for , while , repeat - while)을 이용해 아래 문제들을 구현해보세요.
 - 자연수 하나를 입력받아 그 수의 Factorial 을 구하는 함수
   (Factorial 참고: 어떤 수가 주어졌을 때 그 수를 포함해 그 수보다 작은 모든 수를 곱한 것)
   ex) 5! = 5 x 4 x 3 x 2 x 1*/
func multi(x:Int){
    var j = 1
    for i in 1...x{
        j*=i
    }
    print(j)
}

func multi2(x:Int){
    var j = 1
    var i = 1
    while i > x {
        j*=i
        i+=1
    }
    print(j)
}

 /*자연수 두 개를 입력받아 첫 번째 수를 두 번째 수만큼 제곱하여 반환하는 함수
   (2, 5 를 입력한 경우 결과는 2의 5제곱)*/
func multi3(_ x:Int, _ y:Int){
    var result = 1
    for _ in 1...y{
        result *= x
    }
    print(result)
}
multi3(2, 5)

 /*자연수 하나를 입력받아 각 자리수 숫자들의 합을 반환해주는 함수
   (1234 인 경우 각 자리 숫자를 합치면 10)*/

//
//for chr in "Hello" {
//  print(chr, terminator: " ")
//}
//print()
/*:
 ---
 ## Control Transfer
 ---
 */
/*
 - 자연수 하나를 입력받아 1부터 해당 숫자 사이의 모든 숫자의 합을 구해 반환하는 함수를 만들되,
   그 합이 2000 을 넘는 순간 더하기를 멈추고 바로 반환하는 함수*/

func sum2(_ x: Int){
    var i = 1
    var j = 0
    while i <= x {
        j+=i
        i+=1
        if j > 2000 {
            break
        }
    }
    print(j)
}

sum2(800)


 /*1 ~ 50 사이의 숫자 중에서 20 ~ 30 사이의 숫자만 제외하고 그 나머지를 모두 더해 출력하는 함수
 */

func sum3(){
    
    var j = 0
    for i in 1...50{
        if i >= 20 && i <= 30 { continue }
        j += i
    }
    print(j)
}
sum3()
//: [Next](@next)
