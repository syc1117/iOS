

import UIKit
import RxSwift

/*:
 # window
 */
//obsevable이 1초에 1씩 증가시켜 방출, window는 2초마다 3개씩 수집하여 새로운 obsevable을 생성하여 방출. buffer와 달리 obsevable 형태로 방출한다는 것 주의. 따라서 안에서 obseverble을 재 구독해주어야 값을 확인할 수 있음.
let disposeBag = DisposeBag()


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe{
        print($0)
        
        if let observable = $0.element {
            observable.subscribe{print("inner: ", $0)}
        }
}
    .disposed(by: disposeBag)





