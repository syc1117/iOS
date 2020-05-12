//: [Previous](@previous)
/*:
 ---
 # Strong Reference Cycles
 ---
 */

class Person {
  var pet: Dog?
  func doSomething() {}
  deinit {
    print("Person is being deinitialized")
  }
}

class Dog {
  var owner: Person?
  func doSomething() {}
  deinit {
    print("Dog is being deinitialized")
  }
}



var giftbot: Person? = Person() //count 1
var tory: Dog? = Dog() //count 1

giftbot?.pet = tory //dog count 2
tory?.owner = giftbot//person count 2

giftbot?.doSomething()
tory?.doSomething()

giftbot = nil //person count 1
tory = nil //dog count 1


/*:
 ---
 ### Question
 - 두 객체를 메모리에서 할당 해제하려면 어떻게 해야 할까요?
 ---
 */

/*:
 ---
 ### Answer
 ---
 */
// 순서 주의
// 안에 것 부터 해제 해야하는 이유: 바깥 것을 먼저 해제하면 안쪽 것에 접근할 방법이 없어지기 때문임.

giftbot?.pet = nil
tory?.owner = nil

giftbot = nil
tory = nil




//: [Next](@next)
