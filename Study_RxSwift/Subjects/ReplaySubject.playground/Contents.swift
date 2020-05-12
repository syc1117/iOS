

import UIKit
import RxSwift


/*:
 # ReplaySubject
 */
//하나 이상의 최신 이벤트를 버퍼에 저장함. observer가 구독을 시작하면 버퍼에 있는 모든 이벤트를 전달함.

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let rs = ReplaySubject<Int>.create(bufferSize: 3) //3개의 값만 저장하겠다는 것.

(1...10).forEach { rs.onNext($0) }

rs.subscribe{ print("11>",$0) }.disposed(by: disposeBag) //8, 9, 10 가장 마지막에 저장된 3개의 값만 인쇄

rs.onNext(11)  //print("11>",$0)은 아래 추가된 것까지 추가로 실행됨. 즉, 11> next(11) 실행

rs.subscribe{ print("22>>",$0) }.disposed(by: disposeBag)

rs.onNext(12)

rs.onCompleted()

rs.onNext(13) //onCompleted 아래 것은 반영되지 않음.

rs.subscribe{ print("33>>",$0) }.disposed(by: disposeBag) // Publish, Behavior와 달리 rs.onCompleted() 아래에서 구독해도 위의 것들이 모두 실행됨.
