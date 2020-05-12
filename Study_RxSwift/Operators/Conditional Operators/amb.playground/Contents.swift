
import UIKit
import RxSwift

/*:
 # amb
 */
//amb: 여러 obsevable 중에서 가장 빠른 방출을 하는 것 하나를 선택하여 해당 observable만 채택하여 구독자에 전달.
//여러 서버로 요청을 전달하고 가장 빠른 응답을 처리하는 패턴을 구현
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()
let c = PublishSubject<String>()

//a와 b 중에 빠른 방출을 하는 것을 채택하여 구독자에 전달
a.amb(b)
    .subscribe{print($0)}
    .disposed(by: bag)

a.onNext("A") //a가 먼저 방출했기 때문에 밑에 b는 구독하지 않음.
b.onNext("B")

b.onNext("C") // 구독자에 전달되지 않음
b.onCompleted() // 구독자에 전달되지 않음

//3개 이상일 경우 아래와 같이 배열로 선언하면 됨.
Observable.amb([a,b,c])
    .subscribe{print($0)}
    .disposed(by: bag)
