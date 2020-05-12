

import UIKit
import RxSwift

/*:
 # retryWhen: trigger obsevable에 onNext가 전달될 때 재시도
 사용자가 리프레시 눌렀을 때 재시도 하는 기능 구현할 때 사용할 수 있음.
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
   let currentAttempts = attempts
   print("START #\(currentAttempts)")
   
   if attempts < 3 {
      observer.onError(MyError.error)
      attempts += 1
   }
   
   observer.onNext(1)
   observer.onNext(2)
   observer.onCompleted()
   
   return Disposables.create {
      print("END #\(currentAttempts)")
   }
}

let trigger = PublishSubject<Void>()

source
    .retryWhen { _ in trigger } // trigger가 값을 전달 받을 때 작동
   .subscribe { print($0) }
   .disposed(by: bag)

trigger.onNext(())

