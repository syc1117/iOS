
import UIKit
import RxSwift

/*:
 # sample
 */
//sample: trigger에 next로 값이 전달되는 시점에 data에서 가장 최근 방출된 값 하나를 구독자에 전달함.
//withLatestFrom과 반대로 반복적으로 같은 값을 전달하지 않음. 즉, 한 번 구독자에게 전달한 값은 전달하지 않음.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

data.sample(trigger)
    .subscribe{print($0)}
.disposed(by: bag)

data.onNext("hello")
data.onNext("hi")
trigger.onNext(()) // next(hi) 인쇄. 가장 마지막에 방출 된 값 1개만 인쇄

trigger.onNext(()) // 아무것도 인쇄되지 않음. 한 번 방출된 값은 다시 구독자에 전달하지 않음. data에 값이 2번 들어갔지만 가장 최신 값 1개만 취급.

data.onCompleted() // trigger에 completed 이벤트가 전달되지 않아도 구독자에게 이벤트 전달. 단, trigger.onNext에 값이 전달되지 않으면음실행되지 않음
trigger.onNext(()) // 이 시점에서 구독자에 completed 이벤트 전달함.
