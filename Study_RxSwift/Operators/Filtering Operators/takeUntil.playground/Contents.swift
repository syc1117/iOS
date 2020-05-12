
import UIKit
import RxSwift

/*:
 # takeUntil: trigger가 요소를 방출하기 전까지만 원래 obseverble이 방출을 계속하고, trigger가 요소를 방출하면 completed 됨.
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.takeUntil(trigger)
    .subscribe{print($0)}
    .disposed(by: disposeBag)


subject.onNext(1)
subject.onNext(2) // trigger의 요소 방출 전이므로, 방출됨.
trigger.onNext(3)
subject.onNext(4) // trigger의 요소가 방출되었으므로 completed되면서 방출을 멈춤
