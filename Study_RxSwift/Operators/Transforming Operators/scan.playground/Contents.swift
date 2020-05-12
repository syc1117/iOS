

import UIKit
import RxSwift

/*:
 # scan
 */
//중간 과정과 결과가 모두 필요할 때 사용.
let disposeBag = DisposeBag()

Observable.range(start: 1, count: 10)
    .scan(0, accumulator: +) //0에 1부터 10까지 더하는 것
    .subscribe{print($0)}
    .disposed(by: disposeBag)

