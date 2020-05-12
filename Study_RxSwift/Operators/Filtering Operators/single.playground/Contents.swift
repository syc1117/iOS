
import UIKit
import RxSwift

/*:
 # single: 한 개만 방출, 2개 방출하면 에러
   1) 조건이 없을경우: 첫번째 것만 방출
   2) 조건이 있을 경우: 조건이 충족되는 첫번째만 방출
 */

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//맨 앞의 1을 방출 한후 error를 리턴함. 무조건 한 개만 방출되어야 completed
Observable.from(numbers)
    .single()
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

//numbers 배열에 3이 한 개만 있으므로 3 방출하고 completed 됨.
Observable.from(numbers)
    .single{ $0 == 3 }
    .subscribe{ print($0) }
    .disposed(by: disposeBag)


let subject = PublishSubject<Int>()
subject.single().subscribe{print($0)}
subject.onNext(100) // completed가 자동으로 실행되지는 않음. 또 방출될 수도 있기 때문임. 사용자가 직접 onCompleted를 선언해주어야 함.
subject.onNext(101) // 앞에 100을 방출하고 또 방출했기 때문에 실행되지 않고 error 발생
