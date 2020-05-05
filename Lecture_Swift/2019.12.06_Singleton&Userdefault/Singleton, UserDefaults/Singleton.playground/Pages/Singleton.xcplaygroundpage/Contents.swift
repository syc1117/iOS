//: [Previous](@previous)
import UIKit
/*:
 # Singleton
 - 특정 클래스의 인스턴스에 접근할 때 항상 동일한 인스턴스만을 반환하도록 하는 설계 패턴
 - 한 번 생성된 이후에는 프로그램이 종료될 때까지 항상 메모리에 상주
 - 어플리케이션에서 유일하게 하나만 필요한 객체에 사용
 - UIApplication, AppDelegate 등
 */

/*
 iOS 싱글톤 사용 예
 */
let screen = UIScreen.main
let userDefaults = UserDefaults.standard
let application = UIApplication.shared
let fileManager = FileManager.default
let notification = NotificationCenter.default


/*:
 ## Syntax
 */
//: ### Obj-C
//: ![objc_singleton](objc_singleton.png)
/*:
 ### Swift
 */

class NormalClass {
    var x = 0
}

let someObject1 = NormalClass()
someObject1.x = 5

let someObject2 = NormalClass()
someObject2.x = 1

let someObject3 = NormalClass()
someObject3.x = 10

someObject1.x
someObject2.x
someObject3.x



/*
 static 전역 변수로 선언한 것은 지연(lazy) 생성되므로
 처음 Singleton을 생성하기 전까지 메모리에 올라가지 않음. 쓰기전까지 메모리에 안올라감.
 */

class SingletonClass {
    static let shared = SingletonClass() // 아직 생성된거 아님. 메모리에 안올라감.
    var x = 0
}


let singleton1 = SingletonClass.shared  // 이제 생성되서 메모리에 올라감. let singleton1 = SingletonClass() 여기서 스택에 주소 할당됨. 그러나 밑에서 또 만든 것은 같은 주소를 할당하게 됨. 0x123
singleton1.x = 10

let singleton2 = SingletonClass.shared //0x123
singleton2.x = 20

singleton1.x   //
singleton2.x   //

SingletonClass.shared.x = 30

SingletonClass.shared.x  //
singleton1.x  //
singleton2.x  //



SingletonClass().x = 99
SingletonClass().x   // 변수 생략한 인스턴스화. 위에 99랑 같은게 아님. 아래에서 새롭게 만들면서 위에 99 지정한 클래스 객체는 소멸하고 새로 생성되면서 기본 프로퍼티 값인 0 이 들어옴.
singleton1.x  //
singleton2.x  //



/*
 Q.
 항상 하나의 객체만을 사용하는 것을 보장해야 하는 상황에서
 아래와 같은 싱글톤 클래스를 만들었는데, 현재 상태에서 생길 수 있는 문제점은?
 */

class MySingleton {
    static let shared = MySingleton()
    var x = 0
    
//    private init(){}
}

let object1 = MySingleton.shared
//아래와 같이 여러개 생성 못하도록 하기 위해서 private init(){}을 사용한다.
//let object2 = MySingleton()
//let object3 = MySingleton()
//let object4 = MySingleton()
//






// 여전히 새로운 객체를 만들고 다른 객체에 접근 가능

let object2 = MySingleton()
object1.x = 10
object2.x = 20

object1.x
object2.x




/*
 외부에서 인스턴스를 직접 생성하지 못하도록 강제해야 할 경우 생성자를 private 으로 선언
 단, 일부러 새로운 것을 만들어서 쓸 수 있는 여지를 주고 싶은 경우는 무관
 */

class PrivateSingleton {
    static let shared = PrivateSingleton()
    
    var x = 1
    
    private init() {}
}

//let uniqueSingleton = PrivateSingleton.init()
let uniqueSingleton1 = PrivateSingleton.shared
let uniqueSingleton2 = PrivateSingleton.shared
uniqueSingleton1.x
uniqueSingleton2.x

uniqueSingleton1.x = 20

uniqueSingleton1.x
uniqueSingleton2.x




//: [Next](@next)
