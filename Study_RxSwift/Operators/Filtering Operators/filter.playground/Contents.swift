import UIKit
import RxSwift

/*:
 # filter
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(numbers)
    .filter { $0.isMultiple(of: 2) } // 특정 조건에 해당하는 것만 방출
    .subscribe { print($0)}
    .disposed(by: disposeBag)


