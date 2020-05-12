

import UIKit
import RxSwift

/*:
 # skipWhile: 클로저가 true를 return하는 동안은 방출을 막고 한번 false가 리턴되면 그 순간부터 뒤의 모든 것을 방출하도록 함.
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(numbers)
    .skipWhile { !$0.isMultiple(of: 2) } // 1일때 true이므로 방출되지 않고 2가 들어오면 false가 되면서 2부터 뒤의 모든 것을 방출함.
.subscribe{print($0)}
.disposed(by: disposeBag)
