
import UIKit
import RxSwift

/*:
 # Operators
 */

let bag = DisposeBag()
//연산자는 붙이는 순서에 따라 결과값이 달라지므로 순서에 주의해야함.
//.subscribe 앞에 여러 연산자를 붙여서 추가 할 수 있음.
Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    .take(5) // 앞에서 부터 5개
    .filter({ $0.isMultiple(of: 2) }) // 2의 배수만 거름
    .subscribe { print($0) }
    .disposed(by: bag)
























