
import UIKit
import RxSwift

/*:
 # flatMap
 */
/*
 한 obsevable을 가지고 가공해서 새로운 obsevable을 만드는 것
 http://minsone.github.io/programming/reactive-swift-flatmap-flatmapfirst-flatmaplatest
 참고
 */
let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject.flatMap{ $0.asObservable() }
    .subscribe{print($0)}
    .disposed(by: disposeBag)

subject.onNext(a)
subject.onNext(b)
a.onNext(11)
b.onNext(22)

