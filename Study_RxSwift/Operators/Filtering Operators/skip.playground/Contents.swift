
import UIKit
import RxSwift

/*:
 # skip: 앞에서부터 특정 갯수만큼을 무시하는 것.
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(numbers)
    .skip(3) // 처음 것부터 3개는 무시하고 4부터 방출
    .subscribe{print($0)}
    .disposed(by: disposeBag)
