

import UIKit
import RxSwift

/*:
 # reduce
 */
//초기값과 연산부호를 통해 연산결과를 얻을 때 사용.
//scan과의 차이: scan은 중간과정이 모두 나오지만 reduce는 최종값만 나옴.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let range = Observable.range(start: 1, count: 5)

print("== scan")

range.scan(0, accumulator: +)
   .subscribe { print($0) } // 1, 3, 6, 10, 15 인쇄
   .disposed(by: bag)

print("== reduce")

range.reduce(0, accumulator: +)
.subscribe { print($0) } // 15 인쇄
.disposed(by: bag)


