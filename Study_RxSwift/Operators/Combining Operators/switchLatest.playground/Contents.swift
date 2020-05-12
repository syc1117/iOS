
import UIKit
import RxSwift

/*:
 # switchLatest
 */
//switchLatest: 다른 observable을 받도록 해주는 연산자
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()

let source = PublishSubject<Observable<String>>()

source.switchLatest()
    .subscribe{ print($0) }
    .disposed(by: bag)

a.onNext("1")
source.onNext(a) //a.onNext("1")가 이미 값을 결정했지만 적용 안됨. source.onNext(a) 을 지정한 이후 것만 적용됨.
a.onNext("2") // next(2)인쇄.

source.onNext(b) // b로 switch 되면서 a는 해제됨.
b.onNext("b")

b.onCompleted() // 구독자에 전달되지는 않지만 밑에서 새로운 값을 받지는 못함.
b.onNext("c")

source.onCompleted() // 구독자에 바로 전달

//error는, b와 source 상관없이 바로 구독자로 전달됨.


