

import UIKit
import RxSwift

/*:
 # just
 */
//obsevable을 생성하는 연산자를 operator라고 함.
//프로퍼티 받아서 프로퍼티 그대로 방출
let disposeBag = DisposeBag()
let element = "😀"

Observable.just(element)
   .subscribe {  print($0) }
   .disposed(by: disposeBag)

Observable.just([1, 2, 3])
   .subscribe { print($0) }
   .disposed(by: disposeBag)














