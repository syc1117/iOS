import UIKit

//convinience init의 경우, self.init 먼저 써주지 않으면 안됨.

//extension에서는 convinience init 만 호출 가능함.



//부모클래스와 함께초기화 하는 방법
class Human {
  var name: String
  
  init(name: String) {
    self.name = name
  }
}


class Student: Human {
  var school: String
  
init(name: String, school: String){
self.school = school
super.init(name: name)
    }
}

