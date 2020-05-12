
import UIKit
import RxSwift

/*:
 # elementAt
 */
//특정 index의 값만 방출
let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

Observable.from(fruits)
    .elementAt(1) // 1 index에 해당 하는 것만 방출
    .subscribe{print($0)}
    .disposed(by: disposeBag)













