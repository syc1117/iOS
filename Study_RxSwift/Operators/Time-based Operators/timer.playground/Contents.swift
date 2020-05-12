

import UIKit
import RxSwift

/*:
 # timer
 */

let bag = DisposeBag()

// 구독 후 1초 후부터 값 방출(0부터 시작), 2초 주기로 한개씩 더 방출
// period를 생략하면 면 .seconds(1) 후에 0 방출하고 completed됨.
let o1 = Observable<Int>.timer(.seconds(1), period: .seconds(2), scheduler: MainScheduler.instance)
    .subscribe{ print($0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    o1.dispose()
}

