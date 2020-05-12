

import UIKit
import RxSwift

/*:
 # startWith
 */
//startWith: obsevable이 요소를 방출하기 전에 다른 항목들을 앞 부분에 추가. 주로 기본값이나 시작값을 지정할 때 사용.
let bag = DisposeBag()
let numbers = [1, 2, 3, 4, 5]

Observable.from(numbers)
    .startWith(0)
    .startWith(-1, -2)
    .startWith(-3) // 가장 마지막에 추가되었으므로 가장 먼저 출력됨.
    .subscribe{ print($0)}
    .disposed(by: bag)

