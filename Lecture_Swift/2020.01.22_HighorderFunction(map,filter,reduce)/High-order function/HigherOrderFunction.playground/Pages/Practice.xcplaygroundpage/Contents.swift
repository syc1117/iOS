//: [Previous](@previous)
import Foundation
import UIKit

// 키노트 문제 참고

print("\n---------- [ Practice 1 ] ----------\n")

struct Pet: CustomStringConvertible {
    
  enum PetType {
    case dog, cat, snake, pig, bird
  }
  var type: PetType
  var age: Int
    
    var description: String {
        return "(title: \(type), age: \(age))"
    }
}

let myPet = [
  Pet(type: .dog, age: 13),
  Pet(type: .dog, age: 2),
  Pet(type: .dog, age: 7),
  Pet(type: .cat, age: 9),
  Pet(type: .snake, age: 4),
  Pet(type: .pig, age: 5),
]

// 1번
func sumDogAge(pets: [Pet]) -> Int {
    var sum = 0
    for i in pets {
        sum += i.age
    }
    return sum
}
sumDogAge(pets: myPet)

let sumAge = myPet.reduce(0) {$0 + $1.age}
print(sumAge)

// 2번
func oneYearOlder(of pets: [Pet]) -> [Pet] {
    var array: [Pet] = []
    for i in pets {
        let pet = Pet(type: i.type, age: i.age + 1)
        array.append(pet)
    }
  return array
}
oneYearOlder(of: myPet)

let newArray = myPet.map { Pet(type: $0.type, age: $0.age + 1) }
print(newArray)


/*:
 ---
 ## Practice 2
 ---
 */
print("\n---------- [ Practice 2 ] ----------\n")
let immutableArray = Array(1...40)

//1. 배열의 각 요소 * index 값을 반환하는 함수
let multiple = immutableArray.enumerated().map{ $0 * $1 }

//2. 짝수 여부를 판별하는 함수
let filterEvenNums = multiple.filter { $0.isMultiple(of: 2) }

//3. 두 개의 숫자를 더하여 반환하는 함수
let total = filterEvenNums.reduce(0) {$0 + $1}
print(total)

immutableArray.enumerated().map( * ).filter{ $0.isMultiple(of: 2) }.reduce(0, +)





//: [Next](@next)
