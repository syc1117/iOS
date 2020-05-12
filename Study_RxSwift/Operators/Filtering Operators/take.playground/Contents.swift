
import UIKit
import RxSwift

/*:
 # take: parameter로 전달 받은 정수의 갯수 만큼만 방출
 */
let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


Observable.from(numbers)
    .take(5) // 맨 앞에서 5개만 방출
    .subscribe{print($0)}
    .disposed(by: disposeBag)


