
import UIKit
import RxSwift

/*:
 # flatMapLatest
 */
//flatMapFirst와 반대로 마지막에 전달된 obsevable만 실행함.
let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
   .flatMapLatest { $0.asObservable() }
   .subscribe { print($0) }
   .disposed(by: disposeBag)

subject.onNext(a)
subject.onNext(b)

a.onNext(11) // b가 나중에 전달된 obsevable이기때문에 실행되지 않음.
b.onNext(22)
