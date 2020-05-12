//: [Previous](@previous)
//: - - -
//: # Strong, Unowned, Weak
//: - - -

class Teacher {
  var student: Student?
  deinit {
    print("Teacher is being deinitialized")
  }
}

class Student {
  // strong, unowned, weak
  let teacher: Teacher
//  unowned let teacher: Teacher
//  weak var teacher: Teacher?  //weak는
  
  init(teacher: Teacher) {
    self.teacher = teacher
  }
  deinit {
    print("Student is being deinitialized")
  }
}

var teacher: Teacher? = Teacher()
var student: Student? = Student(teacher: teacher!)
teacher?.student = student //student 카운트 증가, teacher가 죽으면 student도 카운트 까임


print("\n---------- [ teacher release ] ----------\n")
teacher = nil //위에서 unowned, weak을 사용하면 deinit호출

print("\n---------- [ student release ] ----------\n")
student = nil





/***************************************************
 1) strong  : 명시적으로 nil 대입 필요. teacher?.student = nil(안에것 부터 순차대로 nil값 넣어줌)
 2) unowned : 자동으로 deinit. nil 처리 된 속성에 접근하면 런타임 에러 발생
 3) weak    : 자동으로 deinit. nil 처리 된 속성에 접근하면 nil 반환
 ***************************************************/


//: [Next](@next)
