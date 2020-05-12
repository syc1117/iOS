

import UIKit
import RxSwift

/*:
 # timeout
 */

let bag = DisposeBag()

let subject = PublishSubject<Int>()
// 3초 안에 subject에서 방출되는 값이 없으면 error 이벤트 전달
// 0 → error 이벤트
let s1 = subject.timeout(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe{ print("1>>>>\($0)") }
    .disposed(by: bag)

// 3초 안에 subject에서 방출되는 값이 없으면 Observable.just(1) 전달하고 completed 됨.
// 0 → 1 → completed
let s2 = subject.timeout(.seconds(3), other: Observable.just(1) ,scheduler: MainScheduler.instance)
.subscribe{ print("2>>>>\($0)") }
.disposed(by: bag)

//구독시작 1초 후부터 1초 주기로 0부터 1씩 증가하는 요소를 subject에 onNext로 전달
Observable<Int>.timer(.seconds(1), period: .seconds(4), scheduler: MainScheduler.instance)
    .subscribe(onNext: { subject.onNext($0) } )
    .disposed(by: bag)

