

import UIKit
import RxSwift

/*:
 # catchError
 */
//source obsevable이 error가 났을 때 대체할 observable을 설정하는 것.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

subject
   .catchError{ _ in recovery } //recovery를 에러났을 때 사용하도록 설정
   .subscribe { print($0) }
   .disposed(by: bag)

subject.onError(MyError.error)
recovery.onNext(22)
recovery.onCompleted()


