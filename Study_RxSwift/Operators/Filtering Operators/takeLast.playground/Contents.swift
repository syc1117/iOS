

import UIKit
import RxSwift

/*:
 # takeLast: parameter로 전달받은 정수 만큼 뒤에서부터 버퍼에 저장해 두었다가 completed가 될때 subscribe를 실행하고, error가 리턴된 경우에는 아무것도 실행하지 않음.
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


let subject = PublishSubject<Int>()

subject.takeLast(2)
    .subscribe{print($0)}
.disposed(by: disposeBag)

numbers.forEach{ subject.onNext($0)} // 1~10까지 중 끝에 2개인 9와 10을 버퍼에 저장해두었다가 completed되는 순간 subscribe 실행

subject.onNext(11) // 11이 추가되면서 버퍼에있던 9와 10이 10과 11로 바뀜

subject.onCompleted() // completed된 시점에 10, 11 인쇄
