import UIKit

print("------forEach---------")
/*ForEach: collerction의 element들을 가지고 연산하여 사용. 리턴값 없음.*/
let numbers = [1 ,2 ,3, 4]
/* 1234 로 변환해보기 - terminator 사용
  1) 클로져 사용
  2) 함수 만들어서 사용
 */
// terminator : "": 배열의 각 element들을 ""을 사이에 놓고 연달아 붙이게 해줌.

/**클로저 사용**/
numbers.forEach {
    print($0, terminator : " ")
}
print("---------------")
/**함수사용**/
func changing(_ num: Int) {
    print(num, terminator : " ")
}

numbers.forEach(changing(_:))
print("---------------")
/*1~10까지 짝수만 출력하고 9에서 종료*/

(1...10).forEach {
    guard $0 < 9 else { return }
    guard $0.isMultiple(of: 2) else { return }
    print($0)
}

print("------Map---------")
//Map: collerction의 element들을 가지고 연산하여 새로운 배열을 만듦.

let names = ["영민","길동","영희","미애","영철",]

//이름 + 's 로 배열 만들기

let nameArr = names.map { $0 + "'s" }
print(nameArr)

//2가 10개 있는 배열을 만들고 그 배열을 이용하여 인덱스와 엘리멘트 값의 합으로 이루어진 배열 만들기

let numberArr = Array(repeating: 2, count: 10)
let newNumverArr = numberArr.enumerated().map {
    $0 + $1
}
print(newNumverArr)

print("-------filter--------")
//filter: collection의 각 요소를 평가하여 조건을 만족하는 요소만을 새로운 collection으로 변환
//let names = ["영민","길동","영희","미애","영철",] 에서 "영"이 들아간 이름만 추출해서 배열로 만들기

let newNameArr = names.filter {$0.contains("영")}
print(newNameArr)

print("-------reduce--------")
//reduce: collection의 element들을 가지고 연산하여 하나의 값을 도출
// 1~100까지 더한 값 구하기

let sumHundred1 = (1...100).reduce(0) { (result: Int, num: Int) -> Int in
    return result + num
}
let sumHundred2 = (1...100).reduce(0) { $0 + $1 }
print(sumHundred1)
print(sumHundred2)

//문자의 배열을 reduce를 사용하여 하나의 문자로 합치기

let sumNames1 = names.reduce("") { (result, name: String) -> String in
    return result + name
}
let sumNames2 = names.reduce("") { $0 + $1 }
print(sumNames1)
print(sumNames2)

print("-------compactMap--------")
//compactMap: collection에 nil, optional값을 제거하여 배열 생성

let optionalArray = [nil, "A", nil, "B", "C"]
let compactMapArray = optionalArray.compactMap { $0 }
print(compactMapArray)

let nums = [-2, -1, 0, 1, 2]
let newNums = nums.filter { $0 >= 0 }
print(newNums)
let newNums2 = nums.compactMap { $0 >= 0 ? $0 : nil }
print(newNums2)

print("-------flatMap--------")
//flatMap: 중첩된 collection을 하나로 합쳐줌

let nestedArr = [[1, 2, 3], [1, 5, 99], [1, 1]]
let flatmap = nestedArr.flatMap {$0}
print(flatmap)

let nestedArr2 = [[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]]
let flatmap2 = nestedArr2.flatMap{$0}
let flatmap3 = nestedArr2.flatMap{$0}.flatMap{$0}
print(flatmap2)
print(flatmap3)

print("-------연습문제--------")

struct Pet: CustomStringConvertible {
    enum PetType {
        case dog, cat, snake, pig, bird
    }
    var type: PetType
    var age: Int
    
    var description: String {
        return "(type: \(type), age: \(age)) "
    }
}

var myPet = [
    Pet(type: .dog, age: 13),
    Pet(type: .dog, age: 2),
    Pet(type: .dog, age: 7),
    Pet(type: .cat, age: 9),
    Pet(type: .snake, age: 4),
    Pet(type: .pig, age: 5),
]

/* 1번 - Pet 타입 배열을 파라미터로 받아서 그 배열에 포함된 Pet중에 강아지의 나이만을 합산한 결과를 반환하는 함수 구현 + highOrderFunction 사용하는 것 구현*/
print("------연습문제1번 - highoderFunction 미사용------")
func sumDogsAge(_ x: [Pet]) -> Int{
    var sumAge = 0
    for i in x {
        if i.type == .dog  {
            sumAge += i.age
        }
    }
    return sumAge
}
let sumAge1 = sumDogsAge(myPet)
print("------연습문제1번 - forEach 사용------")
var sumAge2 = 0
myPet.forEach { (pet) in
    guard pet.type == .dog else { return }
    sumAge2 += pet.age
}
print(sumAge2)
print("------연습문제1번 - filter & reduce 사용------")
let sumAge3 = myPet.filter{$0.type == .dog}
                   .reduce(0) {$0 + $1.age}
print(sumAge3)

/* 2번 - Pet 타입의 배열을 파라미터로 받아 모든 Pet이 나이를 1살씩 더 먹었을 때의 상태를 지는 새로운 배열을 반환하는 함수 구현 + highOrderFunction 사용하는 것 구현*/

func addOneYearAge(_ x: [Pet]) -> [Pet] {
    var newPet: [Pet] = []
    for pet in x {
        let pet = Pet(type: pet.type, age: pet.age + 1)
        newPet.append(pet)
    }
    return newPet
}

let changeAge = myPet.map { Pet(type: $0.type, age: $0.age + 1) }
print(changeAge)

print("---------------연습문제 2번----------------------")
//아래 배열의 각 index와 element의 값을 곱하고 그 중 홀수를 제외하고 짝수에 대해서만 모든 값을 더하기

let immutableArry = Array(1...40)

print("---------연습문제 2번: highoderFunction 미사용-----------")
//index와 elements값의 곱을 구하는 함수
func multipleIdextWithElements(_ array: [Int]) -> [Int]{
    var multipleArray: [Int] = []
    for (index, number) in array.enumerated() {
        let temporary = index * number
        multipleArray.append(temporary)
    }
return multipleArray
}

multipleIdextWithElements(immutableArry)

// 홀수를 제외하는 함수
func exceptOddNum (_ array: [Int]) -> [Int]{
    var EvenArray: [Int] = []
    for i in array {
        if i.isMultiple(of: 2) {
            EvenArray.append(i)
        }
    }
    return EvenArray
}

//모두 합하는 함수
func total(_ array: [Int]) -> Int{
    var total = 0
    for i in array {
        total += i
    }
    return total
}

//위의 함수를 모두 합치기
let result = total(exceptOddNum(multipleIdextWithElements(immutableArry)))
print(result)

print("---------연습문제 2번: highoderFunction 사용-----------")

let multiple = immutableArry.enumerated().map { $0 * $1 }
let evenArray = multiple.filter { $0.isMultiple(of: 2) }
let result2 = evenArray.reduce(0) {$0 + $1}
print(result2)

//프로퍼티가 뻔할 경우에는 연산자만 남겨두어도 작동함. 단, 연산자만 남길경우 괄호모양이 {}가 아닌 ()라는 점 주의할 것.
let result3 = immutableArry.enumerated()
                           .map(*)
                           .filter({$0.isMultiple(of: 2)})
                           .reduce(0, +)
print(result3)
