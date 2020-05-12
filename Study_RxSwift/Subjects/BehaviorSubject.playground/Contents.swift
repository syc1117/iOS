

import UIKit
import RxSwift



/*:
 # BehaviorSubject
 */
//생성시점에 시작이벤트를 지정 subject로 전달되는 이벤트 중에서 가장 마지막에 전달된 최신이벤트를 저장해 두었다가 새로운 구독자에게 최신 이벤트를 전달함.

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let b = BehaviorSubject<Int>(value: 0)

b.subscribe{ print("1", $0) }.disposed(by: disposeBag)

b.onNext(1)

b.subscribe{ print("22", $0) }.disposed(by: disposeBag)

b.onNext(2)

b.subscribe{ print("333", $0) }.disposed(by: disposeBag) //아래의 구독 코드는 상위 구독 코드 위쪽의 subject를 실행하지 못함. 즉, 2, 3 ,4, 5만 인쇄함.

b.onNext(3)
b.onNext(4)
b.onNext(5)
b.onCompleted() // onCompleted 위까지의 코드는 모두 실행됨. 아래쪽은 불가

b.subscribe{ print("444", $0) }.disposed(by: disposeBag) //b.onCompleted() 아래에서 구독하면 아예 아무 것도 하지 못함.
b.onError(MyError.error) // onCompleted와 마찬가지

