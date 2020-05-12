
import UIKit
import RxSwift


/*:
 # PublishSubject
 */
//기본 형태. 새로운 이벤트를 구독자에게 전달

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<String>()

subject.onNext("Hello")

let o1 = subject.subscribe{ print(">>1", $0) }

subject.onNext("RxSwift") // 위에 subject.onNext("Hello")는 실행되지 않음. subscribe가 생성된 시점 아래의 subject의 값들만 실행함.

let o2 = subject.subscribe{ print(">>2",$0) }

subject.onNext("Subject")

subject.onError(MyError.error)
subject.onCompleted() // onCompleted가 호출된 시점 아래의 subject들은 실행되지 않고 위의 것들은 실행됨.

let o3 = subject.subscribe{ print(">>3",$0) } //subject.onCompleted() 아래에서 구독하면 아예 실행되지 않음.

subject.onNext("ddd")
