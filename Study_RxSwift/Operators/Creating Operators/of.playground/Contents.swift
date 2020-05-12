
import UIKit
import RxSwift

/*:
 # of: 프로퍼티 여러개 받아서 여러개 그대로 방출. just는 한개만 할때 사용.
 */

let disposeBag = DisposeBag()
let apple = "🍏"
let orange = "🍊"
let kiwi = "🥝"

Observable.of(apple, orange, kiwi)
   .subscribe { element in print(element) }
   .disposed(by: disposeBag)

Observable.of([1, 2], [3, 4], [5, 6])
   .subscribe { element in print(element) }
   .disposed(by: disposeBag)












