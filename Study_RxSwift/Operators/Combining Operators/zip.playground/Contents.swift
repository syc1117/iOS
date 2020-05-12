
import UIKit
import RxSwift

/*:
 # zip
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}
//index값이 같은 요소끼리 합쳐주는 연산자
let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

Observable.zip(numbers, strings) {"\($0) : \($1)"}
    .subscribe{print($0)}
.disposed(by: bag)

numbers.onNext(1)
strings.onNext("가")

numbers.onNext(2) //strings에 같은 index를 가지는 값이 없기때문에 아무것도 실행되지 않음.

numbers.onCompleted() // 둘 중 하나라도 error이벤트가 전달되면 종료됨.
strings.onNext("나") // next(2 : 나) 인쇄. numbers가 onCompleted되기 전까지 가지고 있던 값들은 사용됨.

strings.onCompleted() // 둘 다 completed되어야 구독자에게 completed이벤트가 전달됨.
