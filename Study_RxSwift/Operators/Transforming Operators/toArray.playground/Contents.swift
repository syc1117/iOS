

import UIKit
import RxSwift

/*:
 # toArray: 방출되는 요소들을 모두 한 배열에 저장하였다가 onComleted가 선언되는 시점에서 구독자에게 배열을 전달.
 */

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
subject.toArray()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

subject.onNext(0)
subject.onNext(1)

subject.onCompleted() // [0, 1] 인쇄
