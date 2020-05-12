
import UIKit
import RxSwift

/*:
 # flatMapFirst
 */
//처음에 FlatMap을 통해 변환된 obsevable만 구독자에 전달
let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
   .flatMapFirst { $0.asObservable() }
   .subscribe { print($0) }
   .disposed(by: disposeBag)

subject.onNext(a)
subject.onNext(b)

//subject.onNext(a)가 처음 전달되었기 때문에, subject.onNext(b)는 구독자에 전달되지 않음. 따라서,b.onNext(22),b.onNext(222)는 실행되지 않음.
a.onNext(11)
b.onNext(22)
b.onNext(222)
a.onNext(111)
