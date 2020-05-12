
import UIKit
import RxSwift

/*:
 # range
 */

let disposeBag = DisposeBag()
//range: 1씩 증가
Observable.range(start: -5/*반드시 정수*/, count: 10)
   .subscribe { print($0) }
   .disposed(by: disposeBag)





