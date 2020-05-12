

import UIKit
import RxSwift
import RxCocoa

/*:
 # AsyncSubject
 */
//subject로 completed이벤트가 전달되는 시점에 마지막으로 전달된 next이벤트를 구독자로 전달함.

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = AsyncSubject<Int>()

subject.subscribe{ print($0) }.disposed(by: bag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.onCompleted() // onCompleted() 직전 3만 실행됨
subject.onError(MyError.error) //onCompleted()가 없이 onError만 있으면 아무 것도 실행하지 않음.
