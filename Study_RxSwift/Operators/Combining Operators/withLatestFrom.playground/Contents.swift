
import UIKit
import RxSwift

/*:
 # withLatestFrom
 */
//withLatestFrom: trigger에 next이벤트가 전달되면 가장 마지막에 전달된 data의 값 하나를 구독자에 전달함. sample연산자와 달리 같은 값을 반복적으로 구독자에 전달할 수 있음.
//회원가입 버튼을 누르면 text-field에 입력된 값들을 가져오는 것을 구현할 수 있음.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

trigger.withLatestFrom(data)
    .subscribe{ print($0) }
    .disposed(by: bag)

data.onNext("hello") // trigger에 next이벤트가 전달되지 않았기 때문에 실행되지 않음

trigger.onNext(()) // next(hello) 인쇄
trigger.onNext(()) // 똑같이 next(hello) 인쇄. 즉,trigger에 next이벤트가 전달 될때마다 마지막 값이 전달이 됨.

data.onCompleted() // 구독자에 completed가 전달되지 않음.
trigger.onNext(()) // 역시 next(hello) 인쇄. data.onCompleted()되었더라도 data의 마지막값이 구독자로 전달됨.


//data, trigger 둘 중 하나라도 error가 나면 바로 구독자로 전달되고 종료
//trigger에 onCompleted가 전달되어도 바로 구독자에 전달. data는 아님.
