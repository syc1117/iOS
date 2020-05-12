
import UIKit
import RxSwift

/*:
 # skipUntil: prameter로 다른 obsever를 받음. 이 obsever를 trigger라고 하며 trigger가 값을 방출된 이후부터 source observer의 방출된 값이 구독됨. 원래 obsever가 방출됨. 단, parameter로 받은 trigger는 실제로 subscribe를 타지 않음.
 */

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.skipUntil(trigger)
    .subscribe{print($0)}
    .disposed(by: disposeBag)

subject.onNext(0) //trigger가 방출되지 않아 subject도 방출하지 못함.
trigger.onNext(1) // trigger가 방출된 시점 아래의 것만 방출됨.
subject.onNext(2) // trigger가 방출되고 난 이후의 것이므로 방출됨.
subject.onNext(3)
