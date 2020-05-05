//: [Previous](@previous)
/*:
 # Type Check
 */

/*:
 ---
 ## 타입 확인 - type(of: )
 ---
 */
print("\n---------- [ type(of:) ] ----------\n")

type(of: 1)
type(of: 2.0)
type(of: "3")


// Any
let anyArr: [Any] = [1, 2.0, "3"]
type(of: anyArr[0])
type(of: anyArr[1])
type(of: anyArr[2])


// Generic: 타입을 값이 들어가는 순간 정하는 것. 무슨 타입이 들어올지 모를때 사용.
func printGenericInfo<T>(_ value: T) {  //T는 아무걸로 대체할 수 있음.
  let types = type(of: value)
  print("'\(value)' of type '\(types)'")
}
printGenericInfo(1)
printGenericInfo(2.0)
printGenericInfo("3")

func sss<T>(a: T){
    print(a)
}

sss(a: "rr")

/*:
 ---
 ## 타입 비교 - is
 ---
 */
print("\n---------- [ is ] ----------\n")

/***************************************************
 객체 is 객체의 타입 -> Bool (true or false)
 ***************************************************/

let number = 1
number == 1    // 값 비교
number is Int  // 타입 비교


let strArr = ["A", "B", "C"]

if strArr[0] is String {
  "String"
} else {
  "Something else"
}

if strArr[0] is Int {
  "Int"
}


let someAnyArr: [Any] = [1, 2.0, "3"]

for data in someAnyArr {
  if data is Int {
    print("Int type data :", data)
  } else if data is Double {
    print("Double type data : ", data)
  } else {
    print("String type data : ", data)
  }
}



/*:
 ---
 ## 상속 관계
 ---
 */
print("\n---------- [ Subclassing ] ----------\n")

class Human {
  var name: String = "name"
}
class Baby: Human {
  var age: Int = 1
}
class Student: Human {
  var school: String = "school"
}
class UniversityStudent: Student {
  var univName: String = "Univ"
}

let student = Student()
//student is Human  //'is'는 타입을 비교하는 것이므로 부모클래스와 is로 비교할 경우 항상 참임.
//student is Baby
//student is Student

let univStudent = UniversityStudent()
//student is UniversityStudent
//univStudent is Student


/***************************************************
 자식 클래스 is 부모 클래스  -> true
 부모 클래스 is 자식 클래스  -> false
 ***************************************************/


let babyArr = [Baby()]
type(of: babyArr)


// Q. 그럼 다음 someArr 의 Type 은?

let someArr = [Human(), Baby(), UniversityStudent()]
type(of: someArr) //3개가 모두 공통으로 휴먼타입 [1,2,3]을 Int로 타입추론하는 것과 같음. UniversityStudent의 부모클래스는 Student인데 이것역시 Human을 상속받았으므로 상관없음.

//Any, AnyObject 의 차이: Any는 말그대로 아무거나 가능. AnyObject는 클래스들인 경우에만 사용 가능함.

//위의 경우, Any, AnyObject둘다 사용가능하고 명시 안하면 Human타입으로 추론됨.


someArr[0]
//someArr[0] is Human    //
//someArr[0] is Student  //
//someArr[0] is UniversityStudent  //
//someArr[0] is Baby     //
//
//someArr[1] is Human    //
//someArr[1] is Student  //
//someArr[1] is UniversityStudent  //
//someArr[1] is Baby     //
//
//someArr[2] is Human    //
//someArr[2] is Student  //
//someArr[2] is UniversityStudent  //
//someArr[2] is Baby     //


var human: Human = Student()//Student타입. 컨팡일러단계에서만 Human타입
type(of: human)


// 해당 변수의 타입 vs 실제 데이터의 타입 student

// Q. human 변수의 타입, name 속성의 값, school 속성의 값은?
//human.name    //
//human.school  //에러발생이유: 실제로는 타입(동적타입,런타임에서의 타입)이 School이지만 컴파일(정적 타입)은 여전히 런타임 전 단계에서 타입을 Human으로 인식하고있음. 따라서 실행이 안됨.

// Q. Student의 인스턴스가 저장된 human 변수에 다음과 같이 Baby의 인스턴스를 넣으면?
//human = Baby() // 사실 School타입이지만 컴파일러는 Human타입으로 인식하기때문에 Baby로 오류없이 바뀜
//human = UniversityStudent() // 위와 마찬가지.


var james = Student() //****부모클래스를 선언한 변수에 자식 클래스를 다시 담으면 부모클래스는 그대로 유지되고 그 안에 프로퍼티 값만 자식클래스의 값으로 바뀔 뿐 자식 클래스의 특수한 프로퍼티는 사용할 수 없음.
james = UniversityStudent()
type(of: james)
//james = Baby()    //

// Q. 다음 중 james 가 접근 가능한 속성은 어떤 것들인가
//james.name     // Human 속성
//james.age      // Baby 속성
//james.school   // Student 속성
//james.univName // UniversityStudent 속성


// Q. 그럼 james 객체가 univName을 사용할 수 있도록 하려면 뭘 해야 할까요
// 답: 타입캐스팅
/* 타입캐스팅의 적용 대상? segue.destination as? SecondViewController 에서
 SecondViewController는 UIViewController를 상속 받은 것이고
 segue.destination은 분명히 SecondViewController가 맞지만 (segue.destination = SecondViewController() )
 정적 타입(컴파일러 단계에서)에서는
 segue.destination = UIViewController() 이기 때문에
 SecondViewController의 커스터마이징 값을 사용하지 못함.
 즉, segue.destination의 정적타입은 UIViewController이고 동적타입은
 SecondViewController 이 괴리감을 없애주는 것이 타입 캐스팅 */



//: [Next](@next)
