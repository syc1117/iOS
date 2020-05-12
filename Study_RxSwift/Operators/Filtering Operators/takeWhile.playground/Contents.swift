

import UIKit
import RxSwift

/*:
 # takeWhile: skipWhile과 반대로 true가 리턴될 동안만 방출하도록 함. 한번 false가 리턴되면 바로 completed
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(numbers)
    .takeWhile{!$0.isMultiple(of: 2)} // 1은 true이므로 방출, 2는 false이므로 방출하지 않음. 그리고 false가 리턴된 순간 그 뒤의 것도 방출하지 않음.
    .subscribe{print($0)}
    .disposed(by: disposeBag)
