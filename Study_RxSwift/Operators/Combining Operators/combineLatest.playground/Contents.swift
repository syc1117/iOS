
import UIKit
import RxSwift

/*:
 # combineLatest
 */
//두 요소의 가장 마지막 값끼리 합치는 것
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

Observable.combineLatest(greetings, languages){"\($0) \($1)"}
    .subscribe{ print($0) }
    .disposed(by: bag)
//배열로 쓸 경우
//Observable.combineLatest([greetings, languages]){"\($0[0]) \($0[1])"}
//.subscribe{ print($0) }
//.disposed(by: bag)

greetings.onNext("hi")
languages.onNext("World")

greetings.onNext("hello") //hello world 리턴.

greetings.onCompleted()
languages.onNext("RXSwift") //greetings을 onCompleted했어도 마지막 값인 hello을 가지고 있어서 next(hello RXSwift)를 리턴함

languages.onCompleted() // 둘다 onCompleted 이벤트가 전달된 시점에서 비로소 사용자에게 completed가 전달됨.
