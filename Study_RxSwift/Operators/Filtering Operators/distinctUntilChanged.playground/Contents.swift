
import UIKit
import RxSwift

/*:
 # distinctUntilChanged
 */
//연속되는 값을 방출하지 않도록 함. 1,1 이 방출되면 1이 한개만 방출됨. 배열 전체에서 중복제거를 해주는 것이 아님. 연속적으로 같은 값이 방출되는 것만 막아줌.
let disposeBag = DisposeBag()
let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7, 7]

Observable.from(numbers)
    .distinctUntilChanged()
    .subscribe{print($0)}
    .disposed(by: disposeBag)

