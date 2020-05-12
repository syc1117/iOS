
import UIKit
import RxSwift

/*:
 # catchErrorJustReturn: error났을 때 기본값을 설정
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()

subject
    .catchErrorJustReturn(-1) // error났을 때 기본값으로 -1을 방출하고 completed
    .subscribe { print($0) }
    .disposed(by: bag)

subject.onError(MyError.error)

